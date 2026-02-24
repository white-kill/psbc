<template>
  <div class="balance-bar-chart">
    <div ref="chartRef" class="chart-container"></div>
  </div>
</template>

<script>
import * as echarts from "echarts";

export default {
  name: "lineChart",
  props: {
    chartData: {
      type: Object,
      default: () => {},
    },
    isTan: {
      type: Boolean,
      default: true,
    }
  },
  watch: {
    chartData(newValue) {
      if (newValue.chartList) {
        this.initChart();
      }
    },
  },
  data() {
    return {
      chart: null,
      selectedMonth: 0,
    };
  },
  computed: {
    chartList() {
      if (this.chartData && this.chartData.chartList) {
        if (this.chartData.chartList.length > 6) {
          const list = this.chartData.chartList.slice(0, 6);
          return list.reverse();
        } else {
          return this.chartData.chartList;
        }
      }
      return [];
    },
  },
  mounted() {
    this.initChart();
    window.addEventListener("resize", this.handleResize);
  },
  beforeUnmount() {
    window.removeEventListener("resize", this.handleResize);
    if (this.chart) {
      this.chart.dispose();
    }
  },
  methods: {
    initChart() {
      if (!this.chart) {
        this.chart = echarts.init(this.$refs.chartRef);
      } else {
        this.chart.dispose();
        this.chart = echarts.init(this.$refs.chartRef);
      }

      const months = [
        "",
        "",
        ...(this.chartList || []).map((item) => item.month),
      ];
      const values = [
        "",
        "",
        ...(this.chartList || []).map((item) => item.amount),
      ];
      this.selectedMonth = months.length - 1;

      const option = {
        grid: {
          top: "10%",
          left: "5%",
          right: "5%",
          bottom: "10%",
          containLabel: false,
        },
        xAxis: {
          show: false,
          boundaryGap: false,
          type: "category",
          data: months,
        },
        yAxis: {
          show: false,
          type: "value",
        },
        series: [
          {
            type: "line",
            smooth: 0.3,
            label: {
              show: true,
              fontSize: 10,
              color: "#999999",
              formatter: (params) => {
                return this.selectedMonth == params.dataIndex ? params.data.amount:'';
              },
            },
            lineStyle: {
              width: 1,
              color: "#EF864D",
            },
            areaStyle: {
              opacity: 0.8,
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                {
                  offset: 0,
                  color: "#e85a5d60",
                },
                {
                  offset: 1,
                  color: "#e85a5d00",
                },
              ]),
            },
            symbol: "circle",
            itemStyle: {
              color: "#fff",
              borderColor: "#EF864D",
              borderWidth: 2,
            },
            markLine: {
              silent: true,
              symbol: "none",
              data: [
                {
                  xAxis: months[this.selectedMonth],
                  label: {
                    show: true,
                    position: "start",
                    fontSize: 10,
                    color: "#EF864D",
                  },
                  lineStyle: {
                    color: "#EF864D",
                    width: 1,
                  },
                },
                {
                  yAxis: this.chartData.average,
                  label: {
                    show: true,
                    formatter: `${this.isTan ? '平均弹性支出':'平均刚性支出'}\n{x|￥${this.chartData.average}}`,
                    // formatter: function (params) {
                    //     // 使用 HTML 标签
                    //     return `<div><div>平均弹性支出</div><div>平均弹性支出</div></div>`;
                    // },
                    position: "start",
                    color: "#999999",
                    fontSize: 11,
                    distance: -65,
                    lineHeight: 20,
                    rich: {
                      x: {
                        // padding: [0, 42, 0, 0],
                      },
                    },
                  },
                  lineStyle: {
                    color: "#CCCCCC",
                    type: "dashed",
                    width: 1,
                  },
                },
              ],
            },
            data: values,
          },
        ],
      };

      this.chart.setOption(option);

      // this.$nextTick(() => {
      //   const chartWidth = this.chart.getWidth();
      //   console.log(chartWidth, 'chartWidth');
      // })

      // 添加点击事件
      this.chart.on("click", (params) => {
        if (params.componentType === "series") {
          this.selectedMonth = params.dataIndex;
          this.updateChart();
        }
      });
    },

    updateChart() {
      const values = [
        "",
        "",
        ...(this.chartList || []).map((item) => item.amount),
      ];
      const months = [
        "",
        "",
        ...(this.chartList || []).map((item) => item.month),
      ];

      this.chart.setOption({
        series: [
          {
            markLine: {
              silent: true,
              symbol: "none",
              data: [
                {
                  xAxis: months[this.selectedMonth],
                  label: {
                    show: true,
                    position: "start",
                    fontSize: 10,
                    color: "#EF864D",
                  },
                  lineStyle: {
                    color: "#EF864D",
                    width: 1,
                  },
                },
                {
                  yAxis: this.chartData.average,
                  label: {
                    show: true,
                    formatter: `${this.isTan ? '平均弹性支出':'平均刚性支出'}\n{x|￥${this.chartData.average}}`,
                    // formatter: function (params) {
                    //     // 使用 HTML 标签
                    //     return `<div><div>平均弹性支出</div><div>平均弹性支出</div></div>`;
                    // },
                    position: "start",
                    color: "#999999",
                    fontSize: 11,
                    distance: -65,
                    lineHeight: 20,
                    rich: {
                      x: {
                        // padding: [0, 42, 0, 0],
                      },
                    },
                  },
                  lineStyle: {
                    color: "#CCCCCC",
                    type: "dashed",
                    width: 1,
                  },
                },
              ],
            },
            data: values,
          },
        ],
      });
    },

    handleResize() {
      if (this.chart) {
        this.chart.resize();
      }
    },
  },
};
</script>

<style scoped>
.balance-bar-chart {
  width: 100%;
  height: 100%;
}

.chart-container {
  width: 100%;
  height: 100%;
}
</style>
