import importTemplate from "../../utils/importTemplate.js";

export default {
  template: await importTemplate("./components/job/index.html"),
  data: () => ({
    currentMine: "redwood",
    itemLogs: [],
    pickaxes: {
      ["abandoned_mine"]: {
        image: "professional_pickaxe.png",
        label: "Professional Pickaxe",
      },
      ["david_quartz"]: {
        image: "advanced_pickaxe.png",
        label: "Advanced Pickaxe",
      },
      ["redwood"]: {
        image: "normal_pickaxe.png",
        label: "Normal Pickaxe",
      },
    },
    ores: {
      ["abandoned_mine"]: {
        ["first"]: {
          name: "diamond_ore",
          label: "Diamond Ore",
          image: "diamond_ore.png",
        },
        ["second"]: {
          name: "gold_ore",
          label: "Gold Ore",
          image: "gold_ore.png",
        },
        ["third"]: {
          name: "coal",
          label: "Coal",
          image: "coal.png",
        },
      },
      ["david_quartz"]: {
        ["first"]: {
          name: "iron_ore",
          label: "Iron Ore",
          image: "iron_ore.png",
        },
        ["second"]: {
          name: "sandstone",
          label: "Sand Stone",
          image: "sandstone.png",
        },
        ["third"]: {
          name: "limestone",
          label: "Lime Stone",
          image: "limestone.png",
        },
      },
      ["redwood"]: {
        ["first"]: {
          name: "copper_ore",
          label: "Copper Ore",
          image: "copper_ore.png",
        },
        ["second"]: {
          name: "sandstone",
          label: "Sand Stone",
          image: "sandstone.png",
        },
        ["third"]: {
          name: "sulfur",
          label: "Sulfur",
          image: "sulfur.png",
        },
      },
    },
    mineLabels: {
      ["abandoned_mine"]: "Abandoned Mines",
      ["david_quartz"]: "Davis Quartz Area",
      ["redwood"]: "Redwood Lights Area",
    },
    styles: {
      ["abandoned_mine"]: {
        container: "./assets/images/abandoned_mines_container.png",
        minePlaceLabelColor:
          "linear-gradient(90deg, rgba(255, 255, 255, 0.48) 2.72%, rgba(121, 121, 121, 0.48) 100%)",
        line: "./assets/images/abandoned_mines_line.png",
        oreContainerBig:
          "./assets/images/abandoned_mines_ore_container_big.png",
        oreContainerSmall:
          "./assets/images/abandoned_mines_ore_container_small.png",
        pickaxeText: "#06FFD2",
        startButton: "./assets/images/abandoned_mines_start_mining_button.png",
        keyButton: "./assets/images/abandoned_mines_key.png",
        startButtonShadow:
          "0px 4px 2.4px 0px #000 inset, 0px -3px 4.4px 0px #000 inset, 0px 4px 5.5px 0px #06FFD2 inset",
      },
      ["david_quartz"]: {
        container: "./assets/images/davis_quartz_container.png",
        minePlaceLabelColor:
          "linear-gradient(90deg, rgba(255, 186, 171, 0.48) 2.72%, rgba(255, 255, 255, 0.48) 100%)",
        line: "./assets/images/davis_quartz_line.png",
        oreContainerBig: "./assets/images/davis_quartz_mine_ore_container.png",
        oreContainerSmall:
          "./assets/images/davis_quartz_mine_ore_container_small.png",
        pickaxeText: "#FFEDAB",
        startButton: "./assets/images/davis_quartz_start_mining_button.png",
        keyButton: "./assets/images/davis_quartz_key.png",
        startButtonShadow:
          "0px 4px 2.4px 0px #000 inset, 0px -3px 4.4px 0px #000 inset, 0px 4px 5.5px 0px #FFEDAB inset",
      },
      ["redwood"]: {
        container: "./assets/images/redwood_mines_container.png",
        minePlaceLabelColor:
          "linear-gradient(90deg, rgba(255, 237, 171, 0.48) 2.72%, rgba(255, 255, 255, 0.48) 100%)",
        line: "./assets/images/redwood_line.png",
        oreContainerBig: "./assets/images/redwood_lights_ore_container.png",
        oreContainerSmall:
          "./assets/images/redwood_lights_ore_container_small.png",
        pickaxeText: "#FFBAAB",
        startButton: "./assets/images/redwood_start_mining_button.png",
        keyButton: "./assets/images/redwood_key.png",
        startButtonShadow:
          "0px 4px 2.4px 0px #000 inset, 0px -3px 4.4px 0px #000 inset, 0px 4px 5.5px 0px #FFBAAB inset",
      },
    },
    spam : false,
  }),
  components: {},
  computed: {
    ...Vuex.mapState({
      mineStarted: (state) => state.mineStarted,
    }),
    getBG() {
      return {
        backgroundImage: `url(${this.styles[this.currentMine].container})`,
      };
    },
    getBigOreContainer() {
      return {
        backgroundImage: `url(${
          this.styles[this.currentMine].oreContainerBig
        })`,
      };
    },
    getSmallOreContainer() {
      return {
        backgroundImage: `url(${
          this.styles[this.currentMine].oreContainerSmall
        })`,
      };
    },
    getStartButton() {
      return {
        boxShadow: this.styles[this.currentMine].startButtonShadow,
        filter: "drop-shadow(0px 4px 22px #000)",
        backgroundImage: `url(${this.styles[this.currentMine].startButton})`,
      };
    },
    getKeyButton() {
      return {
        boxShadow: this.styles[this.currentMine].startButtonShadow,
        filter: "drop-shadow(0px 4px 22px #000)",
        backgroundImage: `url(${this.styles[this.currentMine].keyButton})`,
      };
    },
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
  methods: {
    keyHandler(event) {
      if (event.keyCode == 69) {
        if(this.spam){
          return
        }
        if (this.mineStarted) {
          this.setMineStarted(false);
          postNUI("stopMine");
        } else {
          this.setMineStarted(true);
          postNUI("startMine");
        }
        this.spam = true
      } // e
    },
    eventHandler(event) {
      switch (event.data.action) {
        case "update_item_logs":
          this.itemLogs = event.data.payload;
          break;
        case "set_current_mine":
          this.currentMine = event.data.payload;
          break;
        default:
          break;
      }
    },
    ...Vuex.mapMutations({
      setMineStarted: "setMineStarted",
    }),
  },
  mounted() {
    setTimeout(() => {
      window.addEventListener("keyup", this.keyHandler);
    }, 100);
    window.addEventListener("message", this.eventHandler);
  },
  beforeUnmount() {
    window.removeEventListener("keyup", this.keyHandler);
  },
};
