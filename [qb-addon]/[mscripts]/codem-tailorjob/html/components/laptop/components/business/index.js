import importTemplate from "../../../../utils/importTemplate.js";
export default {
  template: await importTemplate(
    "components/laptop/components/business/index.html"
  ),
  data: () => ({
    amount : 0,
    filteredLogs:'',
    newname:'',
  }),
  methods: {
    Deposit(){
      postNUI('Deposit', this.amount)

    },
    Withdraw() {
      postNUI('Withdraw', this.amount)
     },
    Save(){
      if(this.newname.length == 0){
        this.newname = this.jobData.name
      }
      postNUI('Save', {
        logo : this.jobData.logo,
        name: this.newname,
      })
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
  computed: {
    getPercentage() {
      let myXP = this.jobData.xp;
      let maxXP = this.xp[this.jobData.level - 1];
      return (100 * myXP) / maxXP;
    },
    getFilteredLogs() {
      if (this.filteredLogs.length > 0) {
        return this.jobData.logs.filter((log) => log.text.toLowerCase().includes(this.filteredLogs.toLowerCase()))

      }
      return this.jobData.logs
    },
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      xp: (state) => state.xp,
      locales: (state) => state.locales,
    }),
  },
  watch:{
    'jobData.name'(val){
      this.newname = jobData.name
    }
  }
};
