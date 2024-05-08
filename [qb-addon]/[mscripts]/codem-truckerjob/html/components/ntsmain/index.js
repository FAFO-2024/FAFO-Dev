import importTemplate from "../../utils/importTemplate.js";
import inlinesvg from "../../utils/inlineSvg.js";

export default {
  template: await importTemplate("components/ntsmain/index.html"),
  data: () => ({
    selectedMission: false,
    selectedRoute: false,
    selectedTruckIndex: 0,
    selectedTruck: {
      name: "packer",
      image: "truck-1.png",
      label: "Packer",
      level : 1,
    },
    showRoutes:false,
  
  }),
  watch:{
    selectedRoute(val){
      this.setTrucks(this.trucksCopy)
      setTimeout(() =>{
        let data = this.trucks.filter((truck) =>{
          return val.vehicle.includes(truck.name)
        })
        this.setTrucks(data)
        this.selectedTruckIndex= 0
        this.selectedTruck = this.trucks[this.selectedTruckIndex]
      }, 200)
    }
  },
  mounted() {
   
    const swiper = new Swiper(".swiper", {
      // Navigation arrows
      navigation: {
        nextEl: ".swiper-arrow",
      },
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
    });
  
  },
  computed: {
    ...Vuex.mapState({
      missions: (state) => state.missions,
      playerData: (state) => state.playerData,
      language: (state) => state.language,
      trucks : (state) => state.trucks,
      trucksCopy : (state) => state.trucksCopy,
      jobInfo : (state) => state.jobInfo,
    }),
    getMissions(){
      return this.missions.filter((data) => this.playerData?.unlockedMissions?.[data.id.toString()])
    },
    getDailyMissionRemainHours() {
      const date2 = new Date(this.playerData?.dailymissions?.resetAt * 1000);
      const date1 = new Date();
      var diff = date2.valueOf() - date1.valueOf();
      var diffInHours = diff / 1000 / 60 / 60; // Convert milliseconds to hours
      return diffInHours?.toFixed(0);
    },
  },
  components: {
    inlinesvg,
  },
  methods: {
    ...Vuex.mapMutations({
    
      createNotification: "createNotification",
      setTrucks: "setTrucks",
    }),
    
    selectRoute(route, companyIndex){
      if(route.reqPoint){
        if(this.playerData.points[companyIndex.toString()] < route.reqPoint){
          this.createNotification("You don't have enough points!")
          return
        }
      }
      this.selectedRoute = route
    },
    selectNextTruck() {
      this.selectedTruckIndex += 1;
      if (this.selectedTruckIndex >= this.trucks.length) {
        this.selectedTruckIndex = 0;
      }
    },
    selectPrevTruck() {
      this.selectedTruckIndex -= 1;
      if (this.selectedTruckIndex < 0) {
        this.selectedTruckIndex =0 ;
      }
    },
    stopJob(){
      postNUI("stopJob")
    },
    startJob() {
      postNUI("startJob", {
        truck: this.selectedTruck,
        route: this.selectedRoute,
        mission : this.selectedMission,
      });
    },
    getBG(bg) {
      return {
        backgroundImage: `url(./assets/images/${bg})`,
        filter: this.showRoutes ? "blur(10px)" : "blur(0)",
      };
    },
    getSmallBG(bg) {
      return {
        backgroundImage: `url(./assets/images/${bg})`,
      };
    },
  },
};
