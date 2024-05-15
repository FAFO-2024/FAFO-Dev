import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "components/laptop/components/orders/index.html"
  ),
  data: () => ({
    activeOrdersPage: "binco",
    orders: {
      ["binco"]: [],
      ["suburban"]: [],
      ["ponsonbys"]: [],
    },
  }),
  async mounted() {
    const data = await postNUI("getOrders");
    this.orders = data;
  },
  methods: {
    setActiveOrdersPage(payload) {
      this.activeOrdersPage = payload;
    },
    SecondsToDate(seconds, includeHours) {
      const date = new Date(null);
      date.setSeconds(seconds); // specify value for SECONDS here
      let day = date.getDate()
      let month = date.getMonth() + 1
      let hours = date.getHours() + 1
      let minutes = date.getMinutes()
      if (minutes < 10) {
        minutes = '0' + minutes
      }
      if (hours < 10) {
        hours = '0' + hours
      }
      if (day < 10) {
        day = '0' + day
      }
      if (month < 10) {
        month = '0' + month
      }

      let formattedClock = `${hours}:${minutes}`

      return `${day}.${month}.${date.getFullYear()} ${formattedClock}`
    },
    TakeOrder(data) {
      data.type = this.activeOrdersPage;
      postNUI("takeOrder", data);
    },
    shipOrder(data) {
      postNUI("shipOrder", data);
    },
  },
  computed: {
    getOrders() {
      let data = [];
      this.orders[this.activeOrdersPage].forEach((element) => {
        const find = this.jobData.orders.find((el) => el.id == element.id);
        if (!find) {
          data.push(element);
        }
      });
      return data;
    },
    getActiveOrders() {
      let data = [];
      for (let key in this.orders) {
        this.orders[key].forEach((element) => {
          const find = this.jobData.orders.find((el) => el.id == element.id);
          if (find) {
            data.push(find);
          }
        });
      }

      return data;
    },
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      locales: (state) => state.locales,
    }),
  },
};
