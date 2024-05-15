import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "components/laptop/components/materialshop/index.html"
  ),
  data: () => ({
    page: "materials",
    searchMaterial: "",
    cartItems: [],
  }),
  methods: {
    addToCart(data) {
      let find = this.cartItems.find((item) => item.name == data.name);
      if (find) {
        find.amount = parseInt(find.amount) + 1;
        return;
      }
      this.cartItems.push({
        ...data,
        amount: 1,
      });
    },
    removeFromCart(name) {
      this.cartItems = this.cartItems.filter((item) => item.name != name);
    },
    decreaseFromCart(name) {
      let find = this.cartItems.find((item) => item.name == name);
      if (find) {
        find.amount = parseInt(find.amount) - 1;
        if (find.amount == 0) {
          this.removeFromCart(name);
        }
      }
    },
    increaseFromCart(name) {
      let find = this.cartItems.find((item) => item.name == name);
      if (find) {
        find.amount = parseInt(find.amount) + 1;
      }
    },
    buyItems() {
      postNUI("buyItems", this.cartItems);
      this.cartItems = [];
    },
  },
  computed: {
    getCartTotal() {
      let total = 0;
      this.cartItems.forEach((element) => {
        total += element.price * element.amount;
      });
      return total;
    },

    getMarketItems() {
      if (this.page == "materials") {
        if (this.searchMaterial.length > 0) {
          return this.marketItems.filter((item) =>
            item.label.toLowerCase().includes(this.searchMaterial.toLowerCase())
          );
        }
        return this.marketItems;
      } else {
        if (this.searchMaterial.length > 0) {
          return this.upgradeItems.filter((item) =>
            item.label.toLowerCase().includes(this.searchMaterial.toLowerCase())
          );
        }
        return this.upgradeItems;
      }
    },
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      cash: (state) => state.cash,
      locales: (state) => state.locales,
      marketItems: (state) => state.marketItems,
      upgradeItems: (state) => state.upgradeItems,
    }),
  },
};
