import importTemplate from "../../utils/importTemplate.js";
export default {
  template: await importTemplate("components/job/index.html"),
  data: () => ({
    swiper: false,
    selectedOutfit: "binco",
    currentSlideIndex: 0,
    processAmount: 1,
    secondsLabel: "",
    upgradeMachineModal: false,
    workersModal: false,
    selectedWorker: false,
    // upgradeData : {
    //   ['2']:{
    //     cost : 25000,
    //     requiredItems : [
    //       {
    //         name : 'iron',
    //         label : 'Iron',
    //         amount : 2,
    //         image : 'iron.png',
    //       },
    //       {
    //         name: 'rope_reel',
    //         label : 'Rope',
    //         amount : 2,
    //         image: 'rope.png',
    //       }
    //     ],
    //     desc: [
    //       'Able to produce “ Suburban “ clothes.',
    //       'Faster production on “ Binco “ clothes.',
    //       'Able to put worker on it',
    //       'Less Production cost on Binco Clothes',
    //     ],
    //   },
    //   ['3']: {
    //     cost: 40000,
    //     requiredItems: [
    //       {
    //         name: 'metal_bobbin',
    //         label: 'Metal Bobbin',
    //         amount: 2,
    //         image: 'metal_bobbin.png',
    //       },
    //       {
    //         name: 'thin_needle',
    //         label: 'Thin Needle',
    //         amount: 2,
    //         image: 'thin_needle.png',
    //       }
    //     ],
    //     desc: [
    //       'Able to produce “ Ponsonbys “ clothes.',
    //       'Faster production on “ Suburban “ clothes.',
    //       'Less production cost on Suburban clothes.',
    //     ],
    //   },
    //   ['4']: {
    //     cost: 50000,
    //     requiredItems: [
    //       {
    //         name: 'steel_bobbin',
    //         label: 'Steel Bobbin',
    //         amount: 2,
    //         image: 'steel_bobbin.png',
    //       },
    //       {
    //         name: 'knitting_wheel',
    //         label: 'Knitting Wheel',
    //         amount: 2,
    //         image: 'knitting_wheel.png',
    //       }
    //     ],
    //     desc: [
    //       'Faster production on “ Ponsonbys “ clothes.',
    //       'Less production cost on Ponsonbys clothes.',
    //     ],
    //   },
    // },
  }),
  methods: {
    ...Vuex.mapMutations({
      setOutfitsData: "setOutfitsData",
    }),
    keyHandler(e) {
      if (e.which == 27) {
        this.CancelJob()
      }
    },
    CancelJob() {
      postNUI("cancelJob");
    },
    startSewing() {
      const outfit = this.outfits[this.selectedOutfit][this.currentSlideIndex];
      postNUI("startSewing", {
        outfit,
        processAmount: this.processAmount,
        worker: this.selectedWorker,
      });
    },
    takeItem() {
      postNUI("takeItem");
    },
    upgradeMachine(items, cost) {
      postNUI("upgradeMachine", {
        items,
        cost,
      });
    },
    setSelectedOutfit(payload) {
      this.selectedOutfit = payload;
      this.swiper.destroy();
      this.swiper = new Swiper(".swiper", {
        navigation: {
          nextEl: ".arrow-right",
          prevEl: ".arrow-left",
        },
        on: {
          slideChange: (swiper) => {
            const index_currentSlide = swiper.realIndex;
            this.currentSlideIndex = index_currentSlide;
            this.$forceUpdate();
          },
        },
      });
    },
    checkItems() {
      if (this.jobData.machines?.[this.jobData.machineid?.toString()] >= 2) {
        this.outfits["binco"].forEach((data) => {
          data.requiredItems.forEach((item) => {
            item.amount -= 2;
          });
        });
        this.setOutfitsData(this.outfits);
      }
      if (this.jobData.machines?.[this.jobData.machineid?.toString()] >= 3) {
        this.outfits["suburban"].forEach((data) => {
          data.requiredItems.forEach((item) => {
            item.amount -= 2;
          });
        });
        this.setOutfitsData(this.outfits);
      }
      if (this.jobData.machines?.[this.jobData.machineid?.toString()] >= 4) {
        this.outfits["ponsonbys"].forEach((data) => {
          data.requiredItems.forEach((item) => {
            item.amount -= 2;
          });
        });
        this.setOutfitsData(this.outfits);
      }
    },
    openWorkersModal() {
      if (this.hasActiveJob) {
        postNUI("notify", this.locales.cant_open);
        return;
      }
      this.workersModal = true;
    },
  },
  watch: {
    selectedOutfit(val, old) {
      if (val == "suburban") {
        if (this.jobData.machines[this.jobData.machineid?.toString()] == 1) {
          this.selectedOutfit = old;
          postNUI("notify", this.locales.upgrade_machine_to_open);
        }
      }
      if (val == "ponsonbys") {
        if (this.jobData.machines[this.jobData.machineid?.toString()] < 3) {
          this.selectedOutfit = old;
          postNUI("notify", this.locales.upgrade_machine_to_open);
        }
      }
    },
    jobData() {
      this.checkItems();
    },
  },
  mounted() {
    window.addEventListener("keyup", this.keyHandler);

    Vue.nextTick(() => {
      if (this.jobData.machines?.[this.jobData.machineid?.toString()] >= 2) {
        this.checkItems();
      }

      this.swiper = new Swiper(".swiper", {
        navigation: {
          nextEl: ".arrow-right",
          prevEl: ".arrow-left",
        },
        on: {
          slideChange: (swiper) => {
            const index_currentSlide = swiper.realIndex;
            this.currentSlideIndex = index_currentSlide;
            this.$forceUpdate();
          },
        },
      });
      const interval = () => {
        if (this.jobData.activeJobs?.[this.jobData.machineid?.toString()]) {
          var startDate = new Date();
          // Do your operations
          var endDate =
            this.jobData.activeJobs?.[this.jobData.machineid?.toString()]
              ?.processTime;
          this.secondsLabel = (
            (endDate.toFixed(0) * 1000 - startDate.getTime()) /
            1000
          ).toFixed(0);
        } else {
          this.secondsLabel = "";
        }
      };
      interval();
      setInterval(() => {
        interval();
      }, 1000);
    });
  },
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      upgradeData: (state) => state.upgradeData,
      outfits: (state) => state.outfits,
      locales: (state) => state.locales,
    }),
    hasActiveJob() {
      let hasActiveJob = false;
      for (let key in this.jobData.activeJobs) {
        const job = this.jobData.activeJobs[key];
        if (job) {
          if (!job.worker) {
            hasActiveJob = true;
          }
        }
      }
      return hasActiveJob;
    },
  },
};
