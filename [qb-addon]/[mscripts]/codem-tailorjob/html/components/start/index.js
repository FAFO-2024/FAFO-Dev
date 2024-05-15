import importTemplate from "../../utils/importTemplate.js";
export default {
  template: await importTemplate("components/start/index.html"),
  data: () => ({
    showTutorial: false,
    currentTutorial: "tailor",
  }),
  methods: {
    setShowTutorial(payload) {
      this.showTutorial = payload;
    },
    toggleCurrentTutorial() {
      if (this.currentTutorial == "tailor") {
        this.currentTutorial = "worker";
      } else {
        this.currentTutorial = "tailor";
      }
    },
    toggleJob() {
      if (this.jobData.started) {
        postNUI("finishJob");
      } else {
        postNUI("startJob");
      }
    },
  },
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      locales: (state) => state.locales,
    }),
  },
};
