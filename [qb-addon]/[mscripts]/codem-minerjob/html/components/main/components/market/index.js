import importTemplate from "../../../../utils/importTemplate.js";
import sell from "./components/sell/index.js";
import buy from "./components/buy/index.js";
import ship from "./components/ship/index.js";
let audioPlayer = false
export default {
  template: await importTemplate(
    "./components/main/components/market/index.html"
  ),
  components: {
    buy,
    sell,
    ship,
  },
  data: () => ({
    activePage: "buy",
  }),
  methods: {
    setActivePage(payload) {
      this.activePage = payload;
      clicksound("mMinerjob-click-btn.mp3")

    },
  },
  computed: {},
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