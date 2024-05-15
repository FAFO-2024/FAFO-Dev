import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "components/laptop/components/name/index.html"
  ),
  data: () => ({
    jobName: "",
  }),
  methods: {
    createTailorData() {
      postNUI("createTailorData", this.jobName);
    },
  },
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      locales: (state) => state.locales,
    }),
  },
};
