const store = Vuex.createStore({
    components: {},

    state: {},
    getters: {},
    mutations: {},
    actions: {}
});
let audioPlayer = null;

const app = Vue.createApp({
    components: {},
    data: () => ({
        show: false,
        activePage: "main",
        currentPage: "main",
        categories: false,
        locales: false,
        mainPageSwiperValue: null,
        routesPageSwiperValue: null,
        selectBusVehicleSwiperValue: null,
        playerData: false,
        headerAnim: false,
        busJobData: {
            route: "none",
            fullseat: 0,
            emptyseat: 0,
            income: 0,
            routename: "none",
            requiredXp: 0,
            abb: false
        },
        routes: false,
        routeData: false,
        mainPageRouteData: false,
        busJobVehicle: false,
        busJobVehicleData: false,
        busJobStartStep: {
            rentthebus: false,
            selectroute: false,
            startthejob: false
        },
        currencyUnit: "$",
        requiredXp: 0,
        dailyMission: false,
        totalTime: 10,
        top50: false,
        notifications: [],
        playerDailyMission: false
    }),
    computed: {
        formattedTime() {
            let minutes = Math.floor(this.totalTime / 60);
            let seconds = this.totalTime % 60;
            return minutes.toString().padStart(2, "0") + ":" + seconds.toString().padStart(2, "0");
        },
        findMyRank() {
            const index = this.top50.findIndex(item => item.name == this.playerData.allData.profiledata.name);
            return index !== -1 ? index + 1 : "50+";
        }
    },

    watch: {},

    beforeDestroy() {},
    mounted() {
        window.addEventListener("keyup", this.keyHandler);
        window.addEventListener("message", this.eventHandler);
        // setTimeout(() => {
        //     this.mainPageSwiper();
        //     this.selectBusVehicleSwiper();
        // }, 100);
    },

    methods: {
        notification(header, text) {
            const timeout = 3000;
            let id = Date.now();
            if (this.notifications.some(notification => notification.text === text)) {
                return;
            }

            let newNotification = {
                id: id,
                text: text,
                header: header,
                timeout: setTimeout(() => {
                    this.notifications = this.notifications.filter(notification => notification.id != id);
                }, timeout)
            };

            this.notifications.push(newNotification);
            clicksound("notification_sound.mp3");
        },
        calculateProgress(mission, complete) {
            return (mission / complete) * 100;
        },
        countdown() {
            if (this.totalTime > 0) {
                setTimeout(() => {
                    this.totalTime--;
                    this.countdown();
                }, 1000);
            } else {
                this.totalTime = 0;
                postNUI("timeFinish");
            }
        },
        keyHandler(event) {
            if (this.activePage == "meter") return;
            if (event.keyCode == 27) {
                this.show = false;
                this.activePage = "main";
                this.currentPage = "main";
                this.busJobStartStep.rentthebus = false;
                this.busJobStartStep.selectroute = false;
                this.busJobStartStep.startthejob = false;
                postNUI("closeMenu");
            }
        },
        selectBusVehicle(val) {
            clicksound("click.wav");
            if (this.busJobStartStep.rentthebus) {
                this.busJobStartStep.rentthebus = false;
                this.busJobStartStep.selectroute = false;
            } else {
                if (this.playerData.allData.profiledata.level >= val.level) {
                    this.busJobStartStep.rentthebus = true;
                } else {
                    this.notification("INFO", this.locales["insufficientlevel"]);
                }
            }
        },
        selectRouteRoutePage(val) {
            clicksound("click.wav");
            this.routeData = val;
        },
        selectRoute(val) {
            clicksound("click.wav");
            if (this.playerData.allData.profiledata.level >= val.level) {
                if (!this.busJobStartStep.rentthebus) {
                    this.notification("INFO", this.locales["choosevehiclefirst"]);

                    return;
                }
                this.busJobStartStep.selectroute = true;
            } else {
                this.notification("INFO", this.locales["insufficientlevel"]);
            }
        },
        changeRouteMainPage(index) {
            clicksound("click.wav");
            const initialSlideData = this.routes[index];
            if (this.playerData.allData.profiledata.level >= initialSlideData.level) {
                this.busJobStartStep.selectroute = false;
                this.mainPageRouteData = initialSlideData;
            } else {
                this.notification("INFO", this.locales["insufficientlevel"]);
            }
        },
        startJob() {
            clicksound("click.wav");
            if (!this.busJobStartStep.selectroute) {
                this.notification("INFO", this.locales["chooseroutefirst"]);
                return;
            }
            if (!this.busJobStartStep.rentthebus) {
                this.notification("INFO", this.locales["choosevehiclefirst"]);
                return;
            }
            this.busJobStartStep.startthejob = true;
            setTimeout(() => {
                postNUI("closeMenu");
                this.busJobStartStep.rentthebus = false;
                this.busJobStartStep.selectroute = false;
                this.busJobStartStep.startthejob = false;
                postNUI("startJob", {
                    busvehiclemodel: this.busJobVehicleData.vehiclename,
                    route: this.mainPageRouteData.name,
                    time: this.mainPageRouteData.time
                });
            }, 250);
            // postNUI("closeMenu");
            //
        },
        selectBusVehicleSwiper() {
            clicksound("click.wav");
            if (this.selectBusVehicleSwiperValue) {
                this.selectBusVehicleSwiperValue.destroy();
            }
            this.selectBusVehicleSwiperValue = new Swiper("#mainswiper3", {
                slidesPerView: 1,
                loop: false,

                slidesPerGroup: 1,
                navigation: {
                    nextEl: "#mainswiperleft",
                    prevEl: "#mainswiperright"
                }
            });
            const initialSlideIndex = this.selectBusVehicleSwiperValue.activeIndex;
            const initialSlideData = this.busJobVehicle[initialSlideIndex];
            this.busJobVehicleData = initialSlideData;
            this.selectBusVehicleSwiperValue.on("slideChange", () => {
                this.busJobStartStep.rentthebus = false;
                this.busJobStartStep.selectroute = false;
                this.busJobStartStep.startthejob = false;
                const activeSlideIndex = this.selectBusVehicleSwiperValue.activeIndex;
                const activeSlideData = this.busJobVehicle[activeSlideIndex];
                this.busJobVehicleData = activeSlideData;
            });
        },

        mainPageSwiper() {
            if (this.mainPageSwiperValue) {
                this.mainPageSwiperValue.destroy();
            }

            this.mainPageSwiperValue = new Swiper("#mainswiper", {
                slidesPerView: 4,
                loop: false,
                spaceBetween: 30,
                slidesPerGroup: 2
            });
            const initialSlideIndex = this.mainPageSwiperValue.activeIndex;
            const initialSlideData = this.routes[initialSlideIndex];
            this.mainPageRouteData = initialSlideData;
        },
        routesPageSwiper() {
            if (this.routesPageSwiperValue) {
                this.routesPageSwiperValue.destroy();
            }

            this.routesPageSwiperValue = new Swiper("#mainswiper2", {
                slidesPerView: 4,
                loop: false,
                spaceBetween: 30,
                slidesPerGroup: 2
            });

            const initialSlideIndex = this.routesPageSwiperValue.activeIndex;
            const initialSlideData = this.routes[initialSlideIndex];
            this.routeData = initialSlideData;

            this.routesPageSwiperValue.on("slideChange", () => {
                const activeSlideIndex = this.routesPageSwiperValue.activeIndex;
                const activeSlideData = this.routes[activeSlideIndex];
                this.routeData = activeSlideData;
            });
        },
        changePage(val) {
            clicksound("click.wav");
            this.busJobStartStep.selectroute = false;
            this.headerAnim = val;
            this.currentPage = false;
            setTimeout(() => {
                if (val == "routes") {
                    setTimeout(() => {
                        if (this.routesPageSwiperValue) {
                            this.routesPageSwiperValue.destroy();
                        }
                    }, 50);

                    setTimeout(() => {
                        this.routesPageSwiper();
                    }, 100);
                }
                if (val == "main") {
                    setTimeout(() => {
                        if (this.selectBusVehicleSwiperValue) {
                            this.selectBusVehicleSwiperValue.destroy();
                        }
                        if (this.mainPageSwiperValue) {
                            this.mainPageSwiperValue.destroy();
                        }
                    }, 50);

                    setTimeout(() => {
                        this.selectBusVehicleSwiper();
                        this.mainPageSwiper();
                    }, 100);
                }
                this.currentPage = val;
            }, 250);
        },
        getCategoryStyles(pageName) {
            if (this.currentPage === pageName) {
                return {
                    background: "linear-gradient(0deg, rgba(255, 255, 255, 0.20) 0%, rgba(255, 255, 255, 0.20) 100%), rgba(181, 28, 41, 0.30)",
                    opacity: 1.0,
                    border: " 2px solid #B51C29"
                };
            } else {
                return {
                    opacity: 0.5,
                    background: "rgba(0, 0, 0, 0.30)"
                };
            }
        },

        getRouteStyles(name, routename) {
            if (name === routename) {
                return {
                    backgroundImage: "url(./images/activebg.png)",
                    backgroundSize: "100% 100%",
                    border: " 5px solid #FF8784",
                    borderRadius: "1vw"
                };
            } else {
                return {
                    backgroundImage: "url(./images/activebg.png)",
                    backgroundSize: "100% 100%"
                };
            }
        },
        routeSwiperStyles(level) {
            if (route.level >= level) {
            } else {
                return {
                    border: "2px solid #5a5a5a73",
                    background: rgba(90, 90, 90, 0.425)
                };
            }
        },
        getMarginStyle() {
            switch (this.headerAnim) {
                case "main":
                    return {
                        marginLeft: "0vw"
                    };
                case "routes":
                    return {
                        marginLeft: "12vw"
                    };
                case "leaderboard":
                    return {
                        marginLeft: "24.5vw"
                    };
                case "profile":
                    return {
                        marginLeft: "37.5vw"
                    };
            }
        },
        mergeData(sqlData, configData) {
            const mergedData = configData.map(mission => {
                const sqlMissionData = sqlData[mission.name];
                return {
                    ...mission,
                    complete: sqlMissionData ? sqlMissionData.copmplete : false,
                    currentCount: sqlMissionData ? sqlMissionData.count : 0,
                    progressbar: sqlMissionData ? this.calculateProgress(sqlMissionData.count, mission.count) : 0
                };
            });
            this.playerDailyMission = mergedData;
        },
        eventHandler(event) {
            switch (event.data.action) {
                case "CHECK_NUI":
                    postNUI("loaded", true);
                    break;
                case "configlocales":
                    this.locales = event.data.payload;
                    setTimeout(() => {
                        postNUI("loadedlocales");
                    }, 1000);
                    break;
                case "OPEN_MENU":
                    this.show = true;
                    this.activePage = "main";
                    this.currentPage = "main";
                    this.headerAnim = "main";
                    this.playerData = event.data.payload.playerData;
                    // this.locales = event.data.payload.locales;
                    this.busJobData.requiredXp = this.requiredXp[this.playerData.allData.profiledata.level];
                    this.mergeData(this.playerData.allData.dailymission, this.dailyMission);

                    setTimeout(() => {
                        if (this.selectBusVehicleSwiperValue) {
                            this.selectBusVehicleSwiperValue.destroy();
                        }
                        if (this.mainPageSwiperValue) {
                            this.mainPageSwiperValue.destroy();
                        }
                    }, 50);

                    setTimeout(() => {
                        this.selectBusVehicleSwiper();
                        this.mainPageSwiper();
                    }, 100);

                    break;
                case "CHECK_SEAT":
                    this.busJobData.fullseat = event.data.payload.fullseat;
                    this.busJobData.emptyseat = event.data.payload.emptyseat;
                    this.busJobData.income = event.data.payload.incomePrice;
                    this.busJobData.abb = event.data.payload.abb;
                    break;
                case "STREET_NAME":
                    this.busJobData.routename = event.data.payload;
                    break;
                case "configRoutes":
                    this.routes = event.data.payload;
                    this.mainPageRouteData = this.routes[0];
                    break;
                case "configBusVehicle":
                    this.busJobVehicle = event.data.payload;
                    break;
                case "OPEN_METERS":
                    if (event.data.payload) {
                        this.activePage = "meter";
                    } else {
                        this.totalTime = 0;
                        this.activePage = "";
                    }

                    break;
                case "configCurrencyUnit":
                    this.currencyUnit = event.data.payload;
                    break;
                case "requiredXp":
                    this.requiredXp = event.data.payload;
                    break;
                case "UPDATE_TIMER":
                    if (event.data.payload === false) {
                        this.totalTime = 0;
                        return;
                    } else {
                        this.totalTime = parseInt(event.data.payload) * 60;
                        this.countdown();
                    }
                    break;
                case "configDailyMission":
                    this.dailyMission = event.data.payload;
                    break;
                case "top50":
                    this.top50 = event.data.payload;
                    break;
                case "CLOSE_MENU_JOB":
                    this.show = false;
                    break;
                case "configCategories":
                    this.categories = event.data.payload;
                    break;
                default:
                    break;
            }
        }
    }
});

app.use(store).mount("#app");
var resourceName = "codem-lstransit";

if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {
        // console.log(error)
    }
};

function clicksound(val) {
    let audioPath = `./sound/${val}`;
    audioPlayer = new Howl({
        src: [audioPath]
    });
    audioPlayer.volume(0.4);
    audioPlayer.play();
}
