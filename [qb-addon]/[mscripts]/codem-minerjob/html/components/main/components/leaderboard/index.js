import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "./components/main/components/leaderboard/index.html"
  ),
  data: () => ({
    leaderboard: {
      data: [],
      playerOrder: false,
    },
  }),
  methods: {},
  computed: {},
  async mounted() {
    this.leaderboard = await postNUI("getLeaderboard");
  },
};
