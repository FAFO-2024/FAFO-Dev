import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "components/laptop/components/workers/index.html"
  ),
  data: () => ({
    page: "workers",
  }),
  methods: {
    setActivePage(payload) {
      this.page = payload;
    },
    HireWorker(data) {
      if (this.page == "workers") {
        postNUI("HireWorker", data);
      } else {
        postNUI("FireWorker", data);
      }
    },
  },
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      avaliableWorkers: (state) => state.avaliableWorkers,
      locales: (state) => state.locales,
    }),
    getAvaliableWorkers() {
      let data = [];
      if (this.page == "workers") {
        this.avaliableWorkers.forEach((element) => {
          const find = this.jobData.workers.find(
            (data) => data.name == element.name
          );
          if (!find) {
            data.push(element);
          }
        });
      } else {
        this.avaliableWorkers.forEach((element) => {
          const find = this.jobData.workers.find(
            (data) => data.name == element.name
          );
          if (find) {
            data.push(element);
          }
        });
      }
      return data;
    },
  },
};
