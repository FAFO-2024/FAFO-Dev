import start from "./components/start/index.js";
import laptop from "./components/laptop/index.js";
import job from "./components/job/index.js";
import inventory from "./components/inventory/index.js";

const Modules = {};

const store = Vuex.createStore({
  state: {
    playerInventory: [],
    outfits: [],
    materials: [],
    jobData: {
      name: false,
      started: false,
      level: 1,
      xp: 0,
      playerName: "",
      pp: "",
    },
    xp: [],
    cash: 0,
    upgradeData: {},
    storageoutfits: {},
    locales: {},
    avaliableWorkers: [],
    upgradeItems: [],
    marketItems: [],
  },
  getters: {},
  mutations: {
    setUpgradeItems(state, payload) {
      state.upgradeItems = payload;
    },
    setMarketItems(state, payload) {
      state.marketItems = payload;
    },
    setAvaliableWorkers(state, payload) {
      state.avaliableWorkers = payload;
    },
    setOutfitsData(state, payload) {
      state.outfits = payload;
    },
    setLocales(state, payload) {
      state.locales = payload;
    },
    setUpgradeData(state, payload) {
      state.upgradeData = payload;
    },
    setCash(state, payload) {
      state.cash = payload;
    },
    setMaterials(state, payload) {
      state.materials = payload;
    },
    setOutfits(state, payload) {
      state.storageoutfits = payload;
    },
    setPlayerInventory(state, payload) {
      state.playerInventory = payload;
    },
    setJobData(state, payload) {
      state.jobData[payload.key] = payload.value;
    },
    setXP(state, payload) {
      state.xp = payload;
    },
  },
  modules: Modules,
});

const app = Vue.createApp({
  data: () => ({
    currentPage: "",
  }),
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      locales: (state) => state.locales,

    }),
    hasActiveJob() {
      let hasActiveJob = false;
      for (let key in this.jobData.activeJobs) {
        const job = this.jobData.activeJobs[key];
        if (job) {
          if (!job.worker) {
            hasActiveJob = true;
          }
        }
      }
      return hasActiveJob;
    },
  },
  methods: {
    keyHandler(e) {
      if (e.which == 27) {
        if (this.hasActiveJob) {
          postNUI("notify", this.locales.close);
          return;
        }
        this.currentPage = false;
        postNUI("close");
      }
    },
    setCurrentPage(payload) {
      this.currentPage = payload;
    },
    eventHandler(event) {
      const payload = event.data.payload;
      switch (event.data.action) {
        case "checknui":
          postNUI("loaded");
          break;
        case "setjobdata":
          this.setJobData({
            key: payload.key,
            value: payload.value,
          });
          break;
        case "openmenu":
          this.setCurrentPage(payload);
          break;
        case "setxp":
          this.setXP(payload);
          break;
        case "setInventory":
          this.setPlayerInventory(event.data.payload);
          break;
        case "setcash":
          this.setCash(payload);
          break;
        case "setMaterials":
          this.setMaterials(event.data.payload);
          break;
        case "setOutfits":
          this.setOutfits(event.data.payload);
          break;
        case "close":
          this.currentPage = false;
          postNUI("close");
          break;
        case "setUpgradeData":
          this.setUpgradeData(event.data.payload);
          break;
        case "setOutfitsData":
          this.setOutfitsData(event.data.payload);
          break;
        case "setLocales":
          this.setLocales(event.data.payload);
          break;
        case "setWorkers":
          this.setAvaliableWorkers(event.data.payload);
          break;
        case "setMarketItems":
          this.setMarketItems(event.data.payload);

          break;
        case "setUpgradeItems":
          this.setUpgradeItems(event.data.payload);
          break;
        default:
          break;
      }
    },

    ...Vuex.mapMutations({
      setJobData: "setJobData",
      setXP: "setXP",
      setCash: "setCash",
      setPlayerInventory: "setPlayerInventory",
      setOutfits: "setOutfits",
      setOutfitsData: "setOutfitsData",
      setMaterials: "setMaterials",
      setUpgradeData: "setUpgradeData",
      setLocales: "setLocales",
      setAvaliableWorkers: "setAvaliableWorkers",
      setUpgradeItems: "setUpgradeItems",
      setMarketItems: "setMarketItems",
    }),
  },
  mounted() {
    window.addEventListener("message", this.eventHandler);
    window.addEventListener("keyup", this.keyHandler);
  },
  components: {
    start,
    laptop,
    job,
    inventory,
  },
});

app.use(store).mount("#app");
String.prototype.format = function () {
  let formatted = this;
  for (let i = 0; i < arguments.length; i++) {
    let regexp = new RegExp("\\{" + i + "\\}", "gi");
    formatted = formatted.replace(regexp, arguments[i]);
  }
  return formatted;
};
