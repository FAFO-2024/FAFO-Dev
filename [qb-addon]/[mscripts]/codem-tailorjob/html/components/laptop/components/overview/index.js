import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "components/laptop/components/overview/index.html"
  ),
  data: () => ({ orders: [] }),
  methods: {
    CancelActiveOrder(data) {
      postNUI("cancelOrder", data.name);
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
  },
  async mounted() {
    const data = await postNUI("getOrders");
    this.orders = data;
  },
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      locales: (state) => state.locales,
    }),
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
  },
};
