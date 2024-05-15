import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "components/laptop/components/leaderboard/index.html"
  ),
  data: () => ({
    data: [],
    filterPlayer: "",
  }),
  async mounted() {
    this.data = await postNUI("getLeaderboard");
    this.data.sort((a, b) => b.level - a.level);
  },
  methods: {},
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      locales: (state) => state.locales,
    }),
    getFilteredLeaderboard() {
      if (this.filterPlayer.length > 0) {
        return this.data.filter((item) =>
          item.name.toLowerCase().includes(this.filterPlayer.toLowerCase())
        );
      }
      return this.data;
    },
    getPlayerLevel() {
      let level = 0;
      this.data.forEach((element, index) => {
        if (element.name == this.jobData.name) {
          level = index + 1;
        }
      });
      return level;
    },
  },
};
