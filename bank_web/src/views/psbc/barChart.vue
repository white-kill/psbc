<template>
  <div class="balance-bar-chart">
    <div ref="chartRef" class="chart-container"></div>
  </div>
</template>

<script>
import * as echarts from "echarts";

export default {
  name: "BarChart",
  props: {
    chartData: {
      type: Object,
      default: () => {},
    },
  },
  watch: {
    chartData(newValue) {
      if(newValue.surplusChartList) {
        this.initChart();
      }
    }
  },
  computed: {
    chartList() {
      if(this.chartData && this.chartData.surplusChartList) {
        if(this.chartData.surplusChartList.length > 6) {
          const list = this.chartData.surplusChartList.slice(0, 6);
          return list.reverse();
        }else{
          return this.chartData.surplusChartList;
        }
      }
      return [];
    },
  },
  data() {
    return {
      chart: null,
      selectedMonth: 0,
    };
  },
  mounted() {
    // this.initChart();
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
      if(!this.chart) {
        this.chart = echarts.init(this.$refs.chartRef);
      }else{
        this.chart.dispose();
        this.chart = echarts.init(this.$refs.chartRef);
      }

      const months = [
        "",
        ...(this.chartList || []).map((item) => item.month),
      ];
      const values = [
        "",
        ...(this.chartList || []).map((item) => item.amount),
      ];
      this.selectedMonth = months.length - 1;

      const option = {
        grid: {
          left: "0",
          right: "0%",
          top: "0%",
          bottom: "0%",
          containLabel: true,
        },
        xAxis: {
          type: "category",
          data: months,
          axisLine: {
            show: true,
            lineStyle: {
              color: "#E5E5E5",
            },
          },
          axisTick: {
            show: false,
          },
          axisLabel: {
            color: "#999999",
            fontSize: 11,
          },
        },
        yAxis: {
          type: "value",
          boundaryGap: false,
          show: false,
          axisTick: {
            show: false,
          },
          axisLabel: {
            show: false,
          },
        },
        // dataZoom: [
        //   {
        //     type: "inside",
        //     start: 0,
        //     end: 50, // 默认显示50%的数据，可以滚动
        //     zoomOnMouseWheel: false,
        //     moveOnMouseMove: true,
        //     moveOnMouseWheel: true,
        //   },
        // ],
        series: [
          {
            name: "结余",
            type: "bar",
            barWidth: 12, // 固定柱状图宽度
            barCategoryGap: 10, // 固定间隔
            data: values.map((value, index) => {
              const isSelected = index === this.selectedMonth;
              return {
                value: value,
                itemStyle: {
                  color: this.getBarColor(value, isSelected),
                },
              };
            }),
            markLine: {
              silent: true,
              symbol: "none",
              label: {
                show: true,
                formatter: `平均结余\n{x|￥${this.chartData.average}}`,
                position: "start",
                color: "#999999",
                fontSize: 11,
                distance: -45,
                lineHeight: 20,
                rich: {
                  x: {
                    // padding: [0, 26, 0, 0],
                  },
                },
              },
              data: [
                {
                  name: "平均结余",
                  yAxis: this.chartData.average,
                  lineStyle: {
                    color: "#CCCCCC",
                    type: "dashed",
                    width: 1,
                  },
                },
              ],
            },
          },
        ],
        graphic: [
          // x轴下方的蓝色箭头（指向选中月份）
          {
            type: "polygon",
            left: this.getArrowPosition(this.selectedMonth, months.length),
            bottom: "35%", // 初始值，会在渲染后更新
            shape: {
              points: [
                [0, 0], // 顶点
                [-6, -8], // 左下角
                [6, -8], // 右下角
              ],
            },
            style: {
              fill: "#4A90E2",
              stroke: "#4A90E2",
            },
          },
        ],
      };

      this.chart.setOption(option);

      // 图表渲染完成后，更新箭头位置到x轴下方
      // 使用 setTimeout 确保 ECharts 完全渲染
      this.$nextTick(() => {
        setTimeout(() => {
          this.updateArrowPosition();
        }, 100);
      });

      // 添加点击事件
      this.chart.on("click", (params) => {
        if (params.componentType === "series") {
          this.selectedMonth = params.dataIndex;
          this.$emit('select', this.chartList[params.dataIndex - 1]);
          this.updateChart();
        }
      });
    },

    getBarColor(value, isSelected) {
      if (isSelected) {
        // 选中的柱状图：淡蓝色渐变
        if (value >= 0) {
          return new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: "#9EC1EB" },
            { offset: 1, color: "#9EC1EB00" },
          ]);
        } else {
          return new echarts.graphic.LinearGradient(0, 1, 0, 0, [
            { offset: 0, color: "#9EC1EB" },
            { offset: 1, color: "#9EC1EB00" },
          ]);
        }
      } else {
        // 未选中的柱状图：灰色渐变
        if (value >= 0) {
          return new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: "#EAE9EE" },
            { offset: 1, color: "#EAE9EE00" },
          ]);
        } else {
          return new echarts.graphic.LinearGradient(0, 1, 0, 0, [
            { offset: 0, color: "#EAE9EE" },
            { offset: 1, color: "#EAE9EE00" },
          ]);
        }
      }
    },

    getArrowPosition(selectedIndex, totalCount) {
      // 计算箭头位置（百分比）
      const percentage = ((selectedIndex + 0.5) / totalCount) * 100 - 2;
      return `${percentage}%`;
    },

    getXAxisBottomPosition() {
      // 动态计算x轴（y=0）的位置
      if (!this.chart) {
        return "10%"; // 默认值
      }

      try {
        // 获取图表容器的高度
        const chartHeight = this.chart.getHeight();

        // 获取第一个类目的索引，用于计算y=0的位置
        const firstCategoryIndex = 0;

        // 将 y=0 转换为像素坐标
        // convertToPixel 参数: (finder, value)
        // finder 可以是 { seriesIndex: 0 } 或 { xAxisIndex: 0, yAxisIndex: 0 }
        // value 是数据坐标 [x, y] 或 [categoryIndex, value]
        const pixel = this.chart.convertToPixel({ seriesIndex: 0 }, [
          firstCategoryIndex,
          0,
        ]);

        if (pixel && pixel.length >= 2) {
          // pixel[1] 是 y=0 的垂直像素位置（相对于图表顶部）
          // 计算距离底部的距离（像素）
          const distanceFromBottom = chartHeight - pixel[1];

          // 转换为百分比，并加上箭头高度（约8px）的偏移
          const arrowHeight = 9;
          const bottomInPixels = distanceFromBottom - arrowHeight;
          const bottomPercentage = (bottomInPixels / chartHeight) * 100;

          return `${bottomPercentage}%`;
        }
      } catch (error) {
        console.warn("计算x轴位置失败:", error);
      }

      return "10%"; // 默认值
    },

    updateArrowPosition() {
      // 更新箭头位置到x轴下方
      const months = ['',...(this.chartList || []).map((item) => item.month)];
      const bottomPosition = this.getXAxisBottomPosition();

      this.chart.setOption({
        graphic: [
          {
            type: "polygon",
            left: this.getArrowPosition(this.selectedMonth, months.length),
            bottom: bottomPosition,
            shape: {
              points: [
                [0, 0], // 顶点
                [-6, -8], // 左下角
                [6, -8], // 右下角
              ],
            },
            style: {
              fill: "#4A90E2",
              stroke: "#4A90E2",
            },
          },
        ],
      });
    },

    updateChart() {
      const values = [
        "",
        ...(this.chartList || []).map((item) => item.amount),
      ];

      this.chart.setOption({
        series: [
          {
            data: values.map((value, index) => {
              const isSelected = index === this.selectedMonth;
              return {
                value: value,
                itemStyle: {
                  color: this.getBarColor(value, isSelected),
                },
              };
            }),
          },
        ],
      });

      // 更新箭头位置
      this.$nextTick(() => {
        setTimeout(() => {
          this.updateArrowPosition();
        }, 100);
      });
    },

    handleResize() {
      if (this.chart) {
        this.chart.resize();
        // 窗口大小改变后，重新计算箭头位置
        this.$nextTick(() => {
          setTimeout(() => {
            this.updateArrowPosition();
          }, 100);
        });
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
