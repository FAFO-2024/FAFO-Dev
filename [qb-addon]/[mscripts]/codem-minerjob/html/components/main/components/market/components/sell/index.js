import importTemplate from "../../../../../../utils/importTemplate.js";
let audioPlayer = false;
export default {
  template: await importTemplate(
    "./components/main/components/market/components/sell/index.html"
  ),
  data: () => ({
    hoveredItem: false,
    items: [],
    cart: [],
    sellItems: [],
  }),
  async mounted() {
    this.items = await postNUI("getItems");
    this.sellItems = await postNUI("getSellItems");
  },
  methods: {
    sell() {
      postNUI("sellItems", this.cart);
      this.cart = [];
      clicksound("mMinerjob-click-btn.mp3");
      setTimeout(async () => {
        this.items = await postNUI("getItems");
      }, 500);
    },
    addToCart(item) {
      const find = this.cart.find((data) => data.name == item.name);
      if (!find) {
        item.amount = 1;
        this.cart.push(item);
      } else {
        find.amount = Number(find.amount) + 1;
      }
      clicksound("mMinerjob-click-btn.mp3");
    },
    decreaseFromCart(item) {
      const find = this.cart.find((data) => data.name == item.name);
      if (find) {
        find.amount = Number(find.amount) - 1;
        if (find.amount == 0) {
          this.cart = this.cart.filter((data) => data.name != data.name);
        }
      }
      clicksound("mMinerjob-click-btn.mp3");
    },
    increaseFromCart(item) {
      const find = this.cart.find((data) => data.name == item.name);
      if (find) {
        find.amount = Number(find.amount) + 1;
      }
      clicksound("mMinerjob-click-btn.mp3");
    },
    removeFromCart(item) {
      this.cart = this.cart.filter((data) => data.name != item.name);
      clicksound("mMinerjob-click-btn.mp3");
    },
  },
  computed: {
    ...Vuex.mapState({
      money: (state) => state.money,
    }),
    getItemAmount() {
      let amount = 0;
      const data = this.items.find(
        (item) => item.name == this.hoveredItem.name
      );

      if (data) {
        amount = data.amount;
      }
      return amount;
    },
    getTotalCart() {
      let total = 0;
      this.cart.forEach((item) => {
        total += item.amount * item.price;
      });
      return total;
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
