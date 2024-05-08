import importTemplate from "../../utils/importTemplate.js";
import inlinesvg from "../../utils/inlineSvg.js";

export default {
  template: await importTemplate("components/leaderboard/index.html"),
  data: () => ({
    leaderboard : {},
  }),
  async mounted() {
      this.leaderboard = await postNUI('getLeaderboard')
      
  },
  computed: {
    ...Vuex.mapState({
      missions: (state) => state.missions,
    }),
  },
  components: {
    inlinesvg,
  },
  methods: {},
};
