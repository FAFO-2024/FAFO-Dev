import importTemplate from "../../../../utils/importTemplate.js";
let audioPlayer = false;
export default {
  template: await importTemplate(
    "./components/main/components/main/index.html"
  ),
  data: () => ({
    selectedArea: "redwood",
    selectedTruck: 0,
    selectedVehicle: false,
    selectedAreaProgress: false,
    trucks: [
      {
        label: "Tip Truck",
        name: "tiptruck",
        image: "truck-1.png",
        level: 1,
      },
      {
        label: "Tip Truck2",
        name: "tiptruck2",
        image: "truck-2.png",
        level: 15,
      },
      {
        label: "Rubble",
        name: "rubble",
        image: "truck-3.png",
        level: 30,
      },
    ],
    areas: {},
  }),
  async mounted() {
    window.addEventListener("message", this.eventHandler);
    const areas = await postNUI("getAreas");
    this.areas = areas;
  },
  methods: {
    ...Vuex.mapMutations({
      createNotification: "createNotification",
    }),
    eventHandler(event) {
      switch (event.data.action) {
        default:
          break;
      }
    },
    startJob() {
      if (!this.selectedVehicle) {
        return this.createNotification("You need to select a vehicle!");
      }
      if (!this.selectedAreaProgress) {
        return this.createNotification("You need to select a area!");
      }

      postNUI("startJob", {
        selectedVehicle: this.selectedVehicle,
        selectedArea: this.selectedAreaProgress,
      });
    },
    selectVehicle() {
      if (this.trucks[this.selectedTruck].level > this.playerData.level) {
        this.createNotification("You don't have enough level.");
        return false;
      }
      this.selectedVehicle = this.trucks[this.selectedTruck].name;
      clicksound("mMinerjob-click-btn.mp3");
    },
    setSelectedArea(payload) {
      this.selectedArea = payload;
      clicksound("mMinerjob-click-btn.mp3");
    },
    selectArea() {
      clicksound("mMinerjob-click-btn.mp3");
      if (!this.selectedVehicle) {
        this.createNotification("You need to select a vehicle first!");
        return;
      }
      if (this.areas[this.selectedArea].level > this.playerData.level) {
        this.createNotification("You don't have enough level.");
        return false;
      }
      this.selectedAreaProgress = this.selectedArea;
    },
    increaseSelectedTruck() {
      clicksound("mMinerjob-click-btn.mp3");

      this.selectedTruck += 1;
      if (this.selectedTruck >= this.trucks.length) {
        this.selectedTruck = 0;
      }
    },
    decreaseSelectedTruck() {
      clicksound("mMinerjob-click-btn.mp3");
      this.selectedTruck -= 1;
      if (this.selectedTruck < 0) {
        this.selectedTruck = this.trucks.length - 1;
      }
    },
    getPercentage(max, process) {
      let myXP = process;
      let maxXP = max;
      return (100 * myXP) / maxXP;
    },
  },
  computed: {
    getStyle() {
      if (this.areas[this.selectedArea]) {
        return {
          backgroundImage: `url(./assets/images/${
            this.areas[this.selectedArea].bg
          })`,
        };
      }
      return {};
    },

    getDailyMissionRemainHours() {
      const date2 = new Date(this.playerData.dailyMissions.resetAt * 1000);
      const date1 = new Date();
      var diff = date2.valueOf() - date1.valueOf();
      var diffInHours = diff / 1000 / 60 / 60; // Convert milliseconds to hours
      return diffInHours.toFixed(0);
    },
    ...Vuex.mapState({
      playerData: (state) => state.playerData,
    }),
  },
};
function clicksound(val) {
  let audioPath = `./${val}`;

  if (audioPlayer && audioPlayer.playing()) {
    audioPlayer.stop();
  } else {
    audioPlayer = new Howl({
      src: [audioPath],
    });
    audioPlayer.volume(0.4);
    audioPlayer.play();
  }
}
