import importTemplate from "../../utils/importTemplate.js";
import main from "./components/main/index.js";
import market from "./components/market/index.js";
import leaderboard from "./components/leaderboard/index.js";
import profile from "./components/profile/index.js";
let audioPlayer = false

export default {
  template: await importTemplate("./components/main/index.html"),
  data: () => ({
    activePage: "main",
  }),
  components: {
    mainpage: main,
    market,
    leaderboard,
    profile,
  },
  computed: {
    ...Vuex.mapState({
      playerData: (state) => state.playerData,
    }),
  },
  methods: {
    setActivePage(payload) {
      this.activePage = payload;
      clicksound("mMinerjob-click-btn.mp3")
    },
  },
};
function clicksound(val) {
  let audioPath = `./${val}`;

  if (audioPlayer && audioPlayer.playing()) {
    audioPlayer.stop();
  } else {
    audioPlayer = new Howl({
      src: [audioPath],
    });
    audioPlayer.volume(0.4);
    audioPlayer.play();
  }
}