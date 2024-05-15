import importTemplate from "../../utils/importTemplate.js";
export default {
  template: await importTemplate("components/inventory/index.html"),
  data: () => ({
    inventoryInputAmount: 1,
  }),
  mounted() {},
  methods: {
    RefreshDragDrop() {
      Vue.nextTick(() => {
        $(".inventory .item").draggable({
          helper: "clone",
          appendTo: ".inventory",
          scroll: false,
          start: (event, ui) => {
            $(ui.helper).css("width", `${$(event.target).width()}px`);
            $(ui.helper).css("height", `${$(event.target).height()}px`);
          },
        });
      });
      $(".player-items").droppable({
        accept: ".tailor-item",
        drop: (event, ui) => {
          if (
            $(ui.helper).attr("item-data") &&
            !isNaN(this.inventoryInputAmount)
          ) {
            const item = JSON.parse($(ui.helper).attr("item-data"));
            if (this.inventoryInputAmount == 0) {
              this.inventoryInputAmount = item.amount;
            }

            postNUI("DragItem", {
              fromInv: "boss",
              amount: this.inventoryInputAmount,
              name: item.name,
              metadata: item.metadata,
              label: item.label,
              image: item.image,
            });
          }
        },
      });
      $(".tailor-items").droppable({
        accept: ".player-item",
        drop: (event, ui) => {
          if (
            $(ui.helper).attr("item-data") &&
            !isNaN(this.inventoryInputAmount)
          ) {
            const item = JSON.parse($(ui.helper).attr("item-data"));
            if (this.inventoryInputAmount == 0) {
              this.inventoryInputAmount = item.amount;
            }

            postNUI("DragItem", {
              fromInv: "player",
              amount: this.inventoryInputAmount,
              name: item.name,
              metadata: item.metadata,
              slot: item.slot,
              label: item.label,
              image: item.image,
            });
          }
        },
      });
    },
  },
  watch: {
    playerInventory() {
      this.RefreshDragDrop();
    },
    "jobData.inventory"() {
      this.RefreshDragDrop();
    },
  },
  computed: {
    ...Vuex.mapState({
      jobData: (state) => state.jobData,
      locales: (state) => state.locales,

      playerInventory: (state) => state.playerInventory,
    }),
  },
};
