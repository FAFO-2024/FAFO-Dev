import importTemplate from "../../utils/importTemplate.js";
import name from "./components/name/index.js";
import overview from "./components/overview/index.js";
import orders from "./components/orders/index.js";
import workers from "./components/workers/index.js";
import materialshop from "./components/materialshop/index.js";
import leaderboard from "./components/leaderboard/index.js";
import business from "./components/business/index.js";
import storage from "./components/storage/index.js";


export default {
  template: await importTemplate("./components/laptop/index.html"),
  data() {
    return {
      page: "storage",
      minute : 0,
      hour : 0,
      day : 0,
      dayLabel: 0,
      monthLabel:0,
    };
  },
  components: {
    name,
    overview,
    orders,
    workers,
    materialshop,
    leaderboard,
    business,
    storage
  },
  watch: {
    "jobData.name"(val) {
      this.setActivePage("overview");
    },
  },
  methods: {
    setActivePage(payload) {
      this.page = payload;
    },
    SetTime() {
      setInterval(() => {
        const date = new Date();
        let Hour = date.getHours();
        let Minute = date.getMinutes();
        if (Hour < 10) {
          Hour = "0" + Hour;
        }

        if (Minute < 10) {
          Minute = "0" + Minute;
        }
        this.minute = Minute;
        this.hour = Hour;
      }, 1000);
    },
    SetDate() {
      const weekday = [
        "Sun",
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat",
      ];
      const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "June",
        "July", "Aug", "Sep", "Oct", "Nov", "Dec"
      ];
      const date = new Date();
      let day = date.getDate();
      var dayIndex = date.getDay();
      let month = date.getMonth() + 1;
      if (day < 10) {
        day = "0" + day;
      }
  
      this.monthLabel = monthNames[month];
      this.day = day;
      this.dayLabel = weekday[dayIndex];
    },
  },
  mounted() {
    if (this.jobData.name) {
      this.setActivePage("overview");
    } else {
      this.setActivePage("name");
    }
    this.SetTime()
    this.SetDate()
  },
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      locales: (state) => state.locales,
    }),
  },
};
