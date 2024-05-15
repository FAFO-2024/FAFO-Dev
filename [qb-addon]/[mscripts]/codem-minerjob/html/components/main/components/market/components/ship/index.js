import importTemplate from "../../../../../../utils/importTemplate.js";
let audioPlayer = false
export default {
  template: await importTemplate(
    "./components/main/components/market/components/ship/index.html"
  ),
  data: () => ({
    shipments: [],
  }),
  methods: {
    shipOrder(ship) {
      postNUI("shipOrder", JSON.stringify(ship));
      clicksound("mMinerjob-click-btn.mp3")

    },
  },
  computed: {},
  async mounted() {
    this.shipments = await postNUI("getShipments");
    this.shipments = JSON.parse(this.shipments);
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