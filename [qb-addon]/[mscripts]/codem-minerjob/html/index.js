import mainpage from "./components/main/index.js";
import job from "./components/job/index.js";
import process from "./components/process/index.js";
let audioPlayer = false;

$(document).ready(function() {
  $('.minigame').hide();
  window.addEventListener('message', function(event) {
      var item = event.data;
      if (item.showUI === true) {
          $('.minigame').show();
      } else if (item.showUI === false) {
          $('.minigame').hide();
      } else if (item.indicator) {
          setIndicatorPos(item.indicator);
      } else if (item.setDifficulty) {
          setIndicator(item.setDifficulty);
      } else if (item.progress) {
          setProgress(item.progress)
      }
  });

  let progressCircle = document.querySelector(".progress");
  let radius = progressCircle.r.baseVal.value;
  let circumference = radius * 2 * Math.PI;
  progressCircle.style.strokeDasharray = circumference;

  function setProgress(percent) {
      progressCircle.style.strokeDashoffset = circumference - (percent / 100) * circumference * -1;
  }

  let indicator = document.querySelector(".indicator");

  function setIndicator(percent) {
      indicator.style.strokeDashoffset = percent * (630 / 100) - 630;
  }

  function setIndicatorPos(pos) {
      indicator.style.transform = "rotate(" + pos + "deg)";
  }
});

const store = Vuex.createStore({
  state: {
    activePage: false,
    playerData: {
      identifier: false,
      level: 1,
      xp: 0,
      name: false,
      avatar: false,
      gatheredOres: 0,
      createdAt: false,
      totalEarnings: 0,
      dailyMissions: {
        data: {},
        resetAt: 0,
      },
      latestWorks: [],
      completedShipments: 0,
    },
    notifications: [],
    mineStarted: false,
    processStarted: false,
    money: 0,
  },
  getters: {},
  mutations: {
    setProcessStarted(state, payload) {
      state.processStarted = payload;
    },
    setMoney(state, payload) {
      state.money = payload;
    },
    setMineStarted(state, payload) {
      state.mineStarted = payload;
    },
    setActivePage(state, payload) {
      state.activePage = payload;
    },
    setPlayerData(state, payload) {
      state.playerData = payload;
    },
    createNotification(state, payload) {
      state.notifications.push(payload);
      setTimeout(() => {
        state.notifications.splice(0, 1);
      }, 3000);
      clicksound("notification_sound.mp3");
    },
  },
});

const app = Vue.createApp({
  data: () => ({}),
  components: {
    mainpage,
    job,
    process,
  },
  methods: {
    close() {
      if (this.mineStarted || this.processStarted) {
        this.createNotification("You can't close the menu while working!");
        return;
      }
      this.setActivePage(false);
      postNUI("close");
    },
    eventHandler(event) {
      switch (event.data.action) {
        case "checknui":
          postNUI("ready");
          break;
        case "open_menu":
          this.setActivePage(event.data.payload.type);
          break;
        case "setPlayerData":
          this.setPlayerData(event.data.payload);
          break;
        case "Notify":
          this.createNotification(event.data.payload);
          break;
        case "close":
          this.close();
          break;
        case "setMoney":
          this.setMoney(event.data.payload);
          break;
        default:
          break;
      }
    },
    keyHandler(event) {
      if (event.keyCode == 27) {
        this.close();
      }
    },
    ...Vuex.mapMutations({
      setActivePage: "setActivePage",
      setPlayerData: "setPlayerData",
      createNotification: "createNotification",
      setMoney: "setMoney",
    }),
  },
  computed: {
    ...Vuex.mapState({
      activePage: (state) => state.activePage,
      notifications: (state) => state.notifications,
      mineStarted: (state) => state.mineStarted,
      processStarted: (state) => state.processStarted,
    }),
  },
  watch: {},
  mounted() {
    window.addEventListener("keyup", this.keyHandler);
    window.addEventListener("message", this.eventHandler);
    document.querySelector("#app").style.display = "block";
  },
});
app.use(store).mount("#app");
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
