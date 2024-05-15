import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "./components/main/components/profile/index.html"
  ),
  data: () => ({
    xp: [],
  }),
  methods: {
    secondsToDate(seconds) {
      const date = new Date(null);
      date.setSeconds(seconds); // specify value for SECONDS here
      let day = date.getDate() + 1;
      let month = date.getMonth() + 1;

      if (day < 10) {
        day = "0" + day;
      }
      if (month < 10) {
        month = "0" + month;
      }

      return `${day}.${month}.${date.getFullYear()}`;
    },
  },
  computed: {
    ...Vuex.mapState({
      playerData: (state) => state.playerData,
    }),
    getPercentage() {
      let myXP = this.playerData.xp;
      let maxXP = this.xp[this.playerData.level - 1];
      return (100 * myXP) / maxXP;
    },
  },
  async mounted() {
    this.xp = await postNUI("getXP");
  },
};
