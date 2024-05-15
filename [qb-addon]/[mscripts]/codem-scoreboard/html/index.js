const app = Vue.createApp({
    data: () => ({
        swiper: false,
        isOpen: false,
        showPlayers : false,
        playerInformations : {
            playerName : '',
            playerPP : '',
            jobLabel : '',
            jobName : '',
        },
        serverName : '',
        playersCount : 0,
        jobs : {},
        robberies : {},
        players : {},
        filteredPlayer : '',
        enablePlayerList : false,
        locale : {},
        isAdmin : false,
        ShowID : false,
        closeKey:27,
    }),
    methods: {
        SetJob(job){
            if(job == this.playerInformations.jobName){
                return
            }
            postNUI("SetJob", job)

        },
        addAlpha(color, opacity) {

            var _opacity = Math.round(Math.min(Math.max(opacity || 1, 0), 1) * 255);
     
            return color + _opacity.toString(16).toUpperCase();
        },
        Close(){
            this.isOpen = false
            postNUI("close")

        },
        keyHandler(e) {
            if (e.which == this.closeKey) { 
                this.Close()
            }
        },

        SetWaypoint(robbery){
            if(robbery.canRob && !robbery.disabledByServer){
                postNUI("SetWaypoint", {
                    coords : robbery.coords
                })
            }

        },

        ToggleRobbery(name){
            postNUI("toggleRobbery", {
                name
            })
        },
        SetShowPlayers(payload){
            if(this.enablePlayerList){
                this.showPlayers = payload
            }
        },
        messageHandler(event) {
            switch (event.data.action) {
                case "CHECK_NUI":
                    postNUI("loaded")
                    break
                case "OPEN_MENU":
                    this.isOpen = true
                    break
                case "SET_INFORMATIONS":
                    this.playerInformations[event.data.payload.type] = event.data.payload.value
                    break
                case "UPDATE_PLAYERS_COUNT":
                    this.playersCount = event.data.payload
                    break
                case "SET_ENABLE_PLAYER_LIST":
                    this.enablePlayerList = event.data.payload
                    break
                case "UPDATE_PLAYERS":
                    this.players = event.data.payload
                    break
                case "SET_SERVER_NAME":
                    this.serverName = event.data.payload
                    break
                case "UPDATE_JOBS":
                    this.jobs = event.data.payload
                    break
                case "UPDATE_ROBBERIES":
                    this.robberies = event.data.payload
                    break
                case "SET_LOCALE":
                    this.locale = event.data.payload
                    break
                case "SET_IS_ADMIN":
                    this.isAdmin = event.data.payload
                    break
                case "SHOW_ID":
                    this.ShowID = event.data.payload
                    break
                case "SET_CLOSE_KEY":   
                    this.closeKey = event.data.payload
                    break
                default:
                    break
            }
        }
    },
    created() {
        window.addEventListener('message', this.messageHandler);

    },
    beforeDestroy() {
        window.removeEventListener('message', this.messageHandler);

    },
    computed: {
        getFilteredPlayers(){
            if(this.filteredPlayer.length > 0){
                return this.players.filter((player) => player.name.toLowerCase().includes(this.filteredPlayer.toLowerCase()))

            }
            return this.players
        }
    },
    mounted() {

        window.addEventListener("keyup", this.keyHandler);

    },
    watch: {
        showPlayers(val){
            if (val) {
                if (this.swiper) {
                    this.swiper.destroy()
               
                }
            } else {
                Vue.nextTick(() => {
                    this.swiper = new Swiper('.swiper', {
                        slidesPerView: 3,
                    });
                })
                
            }
        },
        isOpen(val) {
            if (val) {
                Vue.nextTick(() => {
                    this.swiper = new Swiper('.swiper', {
                        slidesPerView: 3,
                    });
                })
            } else {
                if (this.swiper) {
                    setTimeout(() => {
                        this.swiper.destroy()
                    }, 500)
                }
            }
        }

    }
})


app.mount("#app");


var resourceName = "codem-scoreboard";

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