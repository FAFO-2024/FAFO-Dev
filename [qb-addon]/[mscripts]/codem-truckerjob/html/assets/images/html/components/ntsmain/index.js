import importTemplate from "../../utils/importTemplate.js";
import inlinesvg from "../../utils/inlineSvg.js";

export default {
  template: await importTemplate("components/ntsmain/index.html"),
  data: () => ({
    selectedMission: false,
    selectedRoute: false,
    selectedTruckIndex: 0,
    selectedTruck: {
      name: "packer",
      image: "truck-1.png",
      label: "Packer",
      level : 1,
    },
    trucks: [
      {
        name: "packer",
        image: "truck-1.png",
        label: "Packer",
        level : 1,
      },
      {
        name: "hauler",
        image: "truck-2.png",
        label: "Hauler",
        level : 5,
      },
      {
        name: "phantom3",
        image: "truck-3.png",
        label: "Phantom Classic",
        level : 10,
      },
      {
        name: "mule3",
        image: "truck-4.png",
        label: "Armored Mule",
        level : 15,
      },
      {
        name: "phantom",
        image: "truck-5.png",
        label: "Phantom",
        level : 20,
      },
      {
        name: "benson",
        image: "truck-6.png",
        label: "Benson",
        level : 25,
        desc : "This vehicle is needed for a mission",
      },
      {
        name: "pounder2",
        image: "truck-7.png",
        label: "Pounder Armored",
        level : 30,
        desc : "This vehicle is needed for a mission",
      },
      {
        name: "bison",
        image: "truck-8.png",
        label: "Bison",
        level : 35,
        desc : "This vehicle is needed for a mission",
      },
      {
        name: "terbyte",
        image: "truck-9.png",
        label: "Terbyte",
        level : 40,
        desc : "This vehicle is needed for a mission",
      },
    ],
  }),
  mounted() {
    const swiper = new Swiper(".swiper", {
      // Navigation arrows
      navigation: {
        nextEl: ".swiper-arrow",
      },
      pagination: {
        el: ".swiper-pagination",
      },
    });
  },
  computed: {
    ...Vuex.mapState({
      missions: (state) => state.missions,
      playerData: (state) => state.playerData,
      language: (state) => state.language,

    }),
    getMissions(){
      return this.missions.filter((data) => this.playerData?.unlockedMissions?.[data.id.toString()])
    },
    getDailyMissionRemainHours() {
      const date2 = new Date(this.playerData?.dailymissions?.resetAt * 1000);
      const date1 = new Date();
      var diff = date2.valueOf() - date1.valueOf();
      var diffInHours = diff / 1000 / 60 / 60; // Convert milliseconds to hours
      return diffInHours?.toFixed(0);
    },
  },
  components: {
    inlinesvg,
  },
  methods: {
  
    selectNextTruck() {
      this.selectedTruckIndex += 1;
      if (this.selectedTruckIndex >= this.trucks.length) {
        this.selectedTruckIndex = 0;
      }
    },
    selectPrevTruck() {
      this.selectedTruckIndex -= 1;
      if (this.selectedTruckIndex < 0) {
        this.selectedTruckIndex = this.trucks.length + 1;
      }
    },
    startJob() {
      postNUI("startJob", {
        truck: this.selectedTruck,
        route: this.selectedRoute,
        mission : this.selectedMission,
      });
    },
    getBG(bg) {
      return {
        backgroundImage: `url(./assets/images/${bg})`,
        filter: this.selectedMission ? "blur(10px)" : "blur(0)",
      };
    },
    getSmallBG(bg) {
      return {
        backgroundImage: `url(./assets/images/${bg})`,
      };
    },
  },
};
