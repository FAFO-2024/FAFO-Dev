import importTemplate from "../../utils/importTemplate.js";
let audioPlayer = false
export default {
  template: await importTemplate("./components/process/index.html"),
  data: () => ({
    selectedItem: 0,
    itemLogs: [],
    processItems: [
      {
        fromItem: {
          name: "diamond_ore",
          label: "Diamond Ore",
        },
        toItem: {
          name: "diamond_ingot",
          label: "Diamond Ingot",
          amount: 5,
        },
        requiredItems: [
          {
            name: "ingot_mold",
            label: "Ingot Mold",
          },
        ],
      },
      {
        fromItem: {
          name: "copper_ore",
          label: "Copper Ore",
        },
        toItem: {
          name: "copper_ingot",
          label: "Copper Ingot",
          amount: 5,
        },
        requiredItems: [
          {
            name: "ingot_mold",
            label: "Ingot Mold",
          },
        ],
      },
      {
        fromItem: {
          name: "gold_ore",
          label: "Gold Ore",
        },
        toItem: {
          name: "goldingot",
          label: "Gold Ingot",
          amount: 5,
        },
        requiredItems: [
          {
            name: "ingot_mold",
            label: "Ingot Mold",
          },
        ],
      },
      {
        fromItem: {
          name: "iron_ore",
          label: "Iron Ore",
        },
        toItem: {
          name: "iron_ingot",
          label: "Iron Ingot",
          amount: 5,
        },
        requiredItems: [
          {
            name: "ingot_mold",
            label: "Ingot Mold",
          },
        ],
      },
      {
        fromItem: {
          name: "sandstone",
          label: "Sand Stone",
        },
        toItem: {
          name: "glass",
          label: "Glass",
          amount: 3,
        },
        requiredItems: [
          {
            name: "sticky_gel",
            label: "Sticky Gel",
          },
          {
            name: "glass_mold",
            label: "Glass Mold",
          },
        ],
      },
      {
        fromItem: {
          name: "limestone",
          label: "Lime Stone",
        },
        toItem: {
          name: "concrete",
          label: "Concrete",
          amount: 5,
        },
        requiredItems: [
          {
            name: "concrete_package",
            label: "Concrete Package",
          },
          {
            name: "special_water",
            label: "Special Water",
          },
        ],
      },
      {
        fromItem: {
          name: "sulfur",
          label: "Sulfur",
        },
        toItem: {
          name: "blackpowder",
          label: "Black Powder",
          amount: 2,
        },
        requiredItems: [
          {
            name: "coal",
            label: "Coal",
          },
        ],
      },
    ],
    spam : false
  }),
  components: {},
  computed: {
    ...Vuex.mapState({
      processStarted: (state) => state.processStarted,
    }),
  },
  watch:{
    spam(val){
      if(val){
        setTimeout(() =>{
          this.spam = false
        }, 3000)
      }
    }
  },
  beforeUnmount() {
    window.removeEventListener("keyup", this.keyHandler);
  },
  mounted() {
    setTimeout(() => {
      window.addEventListener("keyup", this.keyHandler);
    }, 100);
    window.addEventListener("message", this.eventHandler);
  },
  methods: {
    ...Vuex.mapMutations({
      setProcessStarted: "setProcessStarted",
      createNotification: "createNotification",
    }),
    eventHandler(event) {
      switch (event.data.action) {
        case "update_item_logs":
          this.itemLogs = event.data.payload;
          break;
        default:
          break;
      }
    },
    keyHandler(event) {
      if (event.keyCode == 69) {
        if(this.spam){
          return
        }
        if (this.processStarted) {
          postNUI("stopProcess");
          this.setProcessStarted(false);
        } else {
          postNUI("startProcess", this.processItems[this.selectedItem]);
          this.setProcessStarted(true);
        }
        this.spam = true
      } // e
    },
    increaseSelectedItem() {
      if (this.processStarted) {
        this.createNotification("You can't change the item while working!");
        return;
      }
      this.selectedItem += 1;
      if (this.selectedItem >= this.processItems.length) {
        this.selectedItem = 0;
      }
      clicksound("mMinerjob-click-btn.mp3")

    },
    decreaseSelectedItem() {
      if (this.processStarted) {
        this.createNotification("You can't change the item while working!");
        return;
      }
      this.selectedItem -= 1;
      if (this.selectedItem < 0) {
        this.selectedItem = this.processItems.length - 1;
      }
      clicksound("mMinerjob-click-btn.mp3")

    },
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