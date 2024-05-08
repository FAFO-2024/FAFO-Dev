import importTemplate from "../../utils/importTemplate.js";
import inlinesvg from "../../utils/inlineSvg.js";

export default {
  template: await importTemplate("components/companies/index.html"),
  data: () => ({
    selectedCompany: 0,
    companies: [
      {
        label: "National Transfer & Storage Co.",
        logo: "./assets/images/logo_1.png",
      },
      {
        label: "The Grain Of Truth Company",
        logo: "./assets/images/logo_2.png",
      },
      {
        label: "Redwood Cigarettes Company",
        logo: "./assets/images/logo_3.png",
      },
      {
        label: "You Tool Company",
        logo: "./assets/images/logo_4.png",
      },
      {
        label: "Premium Deluxe Motorsport",
        logo: "./assets/images/logo_5.png",
      },
      {
        label: "Fruit Computers Company",
        logo: "./assets/images/logo_6.png",
      },
      {
        label: "Ron Oil Company",
        logo: "./assets/images/logo_7.png",
      },
      {
        label: "Merry Weather Security",
        logo: "./assets/images/logo_8.png",
      },
    ],
  }),
  computed: {
    ...Vuex.mapState({
      missions: (state) => state.missions,
      playerData: (state) => state.playerData,
      language: (state) => state.language,

    }),
    getSelectedMissions() {
      return this.missions.filter(
        (mission) => mission.companyIndex == this.selectedCompany
      );
    },
  },
  mounted() {},
  components: {
    inlinesvg,
  },
  methods: {
    getBG(bg) {
      return {
        backgroundImage: `url(./assets/images/${bg})`,
      };
    },
    UnlockMission(mission){
      postNUI('UnlockMission', {mission})
    }
  },
};
