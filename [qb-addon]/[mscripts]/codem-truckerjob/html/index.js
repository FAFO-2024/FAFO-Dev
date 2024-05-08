import inlinesvg from "./utils/inlineSvg.js";
import ntsmain from "./components/ntsmain/index.js";
import companies from "./components/companies/index.js";
import profile from "./components/profile/index.js";
import leaderboard from "./components/leaderboard/index.js";

const store = Vuex.createStore({
  state: {
    activePage: "main",
    missions: [],
    jobInfo: {},
    notifications: [],
    playerData: {},
    xp: {},
    language: {},
    trucks: [],
    trucksCopy: [],
  },
  mutations: {
    setTrucks(state, payload) {
      state.trucks = payload

    },
    setTrucksCopy(state, payload) {
      state.trucksCopy = payload
    },
    setLanguage(state, payload) {
      state.language = payload
    },
    setPlayerData(state, payload) {
      state.playerData[payload.key] = payload.value
    },
    createNotification(state, payload) {
      state.notifications.push(payload);
      setTimeout(() => {
        state.notifications.splice(0, 1);
      }, 3000);
    },
    setActivePage(state, payload) {
      state.activePage = payload;
    },
    setJobInfo(state, payload) {
      state.jobInfo[payload.key] = payload.value
    },
    setMissions(state, payload) {
      state.missions = payload
    },
    setXP(state, payload) {
      state.xp = payload
    },
  },
});

const app = Vue.createApp({
  data: () => ({
    isOpen: false,
    showPhone: false,
  }),
  components: {
    inlinesvg,
    ntsmain,
    companies,
    profile,
    leaderboard,
  },
  methods: {
    ...Vuex.mapMutations({
      setActivePage: "setActivePage",
      setMissions: "setMissions",
      setJobInfo: "setJobInfo",
      createNotification: "createNotification",
      setPlayerData: "setPlayerData",
      setXP: "setXP",
      setLanguage: "setLanguage",
      setTrucks: "setTrucks",
      setTrucksCopy: "setTrucksCopy",
    }),

    eventHandler(event) {
      switch (event.data.action) {
        case "open":
          this.isOpen = true
          break;
        case "setJobInfo":
          this.setJobInfo({
            key: event.data.payload.key,
            value: event.data.payload.value,

          })
          break
        case "checknui":
          postNUI('ready')
          break
        case "close":
          this.isOpen = false
          postNUI('close')
          break
        case "set_missions":
          this.setMissions(event.data.payload)
          break
        case "createNotification":
          this.createNotification(event.data.payload)
          break
        case "SyncPlayerDataByKey":
          this.setPlayerData({
            key: event.data.payload.key,
            value: event.data.payload.value
          })
          break

        case "acceptillegal":
          sound('trevor-phonecall.mp3')

          break
        case "declineillegal":
          this.showPhone = false

          break
        case "callillegal":
          this.showPhone = true
          sound('mTruckerjob-Ringtone.mp3')

          break
        case "setTrucks":
          this.setTrucks(event.data.payload)
          break
        case "setTrucksCopy":
          this.setTrucksCopy(event.data.payload)
          break
        case "setXP":
          this.setXP(event.data.payload)
          break
        case "setLanguage":
          this.setLanguage(event.data.payload)
          break
        default:
          break;
      }
    },
    keyHandler(event) {
      if (event.keyCode == 27) {
        this.isOpen = false
        postNUI('close')
      }
    },
  },
  computed: {
    ...Vuex.mapState({
      activePage: (state) => state.activePage,
      jobInfo: (state) => state.jobInfo,
      notifications: (state) => state.notifications,
      playerData: (state) => state.playerData,
      language: (state) => state.language,

    }),
    notificationPosition() {
      if (this.isOpen) {
        return {
          left: '1rem',
          bottom: '1rem',
        }
      } else {
        return {
          top: '1rem',
          left: '50%',
          transform: 'translateX(-50%)'
        }
      }
    }
  },
  mounted() {
    window.addEventListener("keyup", this.keyHandler);
    window.addEventListener("message", this.eventHandler);
    document.querySelector('#app').style.display = 'block'

  },
});
app.use(store).mount("#app");
let audioPlayer = false;

function sound(val) {
  let audioPath = `./${val}`;

  if (audioPlayer && audioPlayer.playing()) {
    audioPlayer.stop();
  }
  audioPlayer = new Howl({
    src: [audioPath],
  });
  audioPlayer.volume(0.4);
  audioPlayer.play();
}
