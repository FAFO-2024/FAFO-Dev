import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "components/laptop/components/storage/index.html"
  ),
  data: () => ({
    search: "",
    page: "materials",
  }),
  methods: {
    getItems() {
      let data = [];
      if (this.page == "materials") {
        this["materials"].forEach((element) => {
          if (this.jobData?.inventory) {
            const filter = this.jobData.inventory.filter(
              (item) => item.name == element
            );
            filter.forEach((item) => {
              data.push(item);
            });
          }
        });
      } else {
        this["storageoutfits"].forEach((element) => {
          if (this.jobData?.inventory) {
            const filter = this.jobData.inventory.filter(
              (item) => item.name == element
            );
            filter.forEach((item) => {
              data.push(item);
            });
          }
        });
      }

      if (this.search.length > 0) {
        return data.filter((item) =>
          item.label.toLowerCase().includes(this.search.toLowerCase())
        );
      }

      return data;
    },
  },
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      materials: (state) => state.materials,
      storageoutfits: (state) => state.storageoutfits,
      locales: (state) => state.locales,
    }),
  },
};
