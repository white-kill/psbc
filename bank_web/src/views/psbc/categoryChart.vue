<template>
  <div class="main">
    <div class="chat">
      <div class="active"></div>
      <div class="chart-content" ref="chart">
        <div class="chart-content" ref="chartRef"></div>
      </div>
    </div>
    <div class="list">
      <div class="title">
        <div class="title-left">
          总{{ incomeExpenseType == '1' ? '收入' : '支出' }}
          ￥
          <span>{{ formatAmount(Math.abs(incomeExpenseType == '1' ? incomeTotal : expensesTotal)) }}</span>
        </div>
        <div class="title-right">
          <span>{{ dateTimeTitle }}{{ type == 0 ? '月' : '年' }}共{{ total }}笔</span>
          <img class="title-right-icon" :src="billInfoIcon" alt=""></img>
        </div>
      </div>
      <van-list
          :immediate-check="false"
          style="min-height: 70vh"
          v-model="loading"
          :finished="finished"
          :error="error"
          finished-text="没有更多了"
          @load="nextPages"
      >
        <div class="item" v-for="(item,index) in list" :key="index">
          <div class="item-left">
            <div class="item-name">
              {{ item.excerpt }}
            </div>
            <div class="item-bank">
              {{ item.bankCard }}
            </div>
          </div>
          <div class="item-right">
            <div class="item-amount">
              {{ momneyStr(item.amount) }}
            </div>
            <div class="item-time">
              {{ item.transactionTime }}
            </div>
          </div>
        </div>
      </van-list>
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import {mapState} from "vuex";
import {remToPx, formatAmount} from "@/utils";
import {billAnalysis, getBillCategoryList} from "@/api";
import billInfoIcon from '/src/assets/image/bill-info-icon.png';

export default {
  data() {
    return {
      billInfoIcon: billInfoIcon,
      chart: null,
      formatAmount: formatAmount,
      status: 'loading',
      name: '',
      trendList: [],
      type: '', // 0月度 1年度
      pageNum: 1,
      pageSize: 10,
      list: [],
      total: 1,
      dateTime: '',
      incomeExpenseType: '', // 1收入 2支出
      expensesTotal: 0,
      incomeTotal: 0,
      zoomTimer: null, // 添加防抖定时器
      loading: false,
      finished: false,
      obj: '',
      error: false,
    }
  },
  computed: {
    ...mapState(['token']),
    momneyStr() {
      return (amount) => {
        let num = parseFloat(amount)
        if (num > 0) {
          return `￥${formatAmount(num.toFixed(2))}`
        } else {
          return `-￥${formatAmount(Math.abs(num).toFixed(2))}`
        }
      }
    },
    dateTimeTitle() {
      if (this.type == 0) {
        return this.dateTime.slice(5);
      } else {
        return this.dateTime.slice(0, 4);
      }
    },
    chatData() {
      const incomeList = this.trendList.map(item => item.income);
      const expensesList = this.trendList.map(item => Math.abs(item.expenses));
      const dateTimeList = this.trendList.map(item => {
        const date = new Date(item.dateTime);
        if (this.type == 1) {
          return `${date.getFullYear()}年`;
        }
        return `${date.getMonth() + 1}月`;
      });
      return {
        incomeList,
        expensesList,
        dateTimeList
      };
    },
  },
  mounted() {
    // 监听Flutter传来的数据
    window.addEventListener('flutter_onMessage', this.handleFlutterData);
    // let data = {name: '购物', type: 0, dateTime: '2025-12', incomeExpenseType: '2'}
    // this.name = data.name
    // this.type = data.type
    // this.dateTime = data.dateTime
    // this.incomeExpenseType = data.incomeExpenseType
    // console.log(this.dateTime)
  },
  created() {

  },
  beforeUnmount() {
    window.removeEventListener('flutter_onMessage', this.handleFlutterData);
  },
  methods: {
    handleFlutterData(event) {
      if (event.detail) {
        let data = event.detail;
        this.name = data.name
        this.type = data.type
        this.dateTime = data.dateTime
        this.incomeExpenseType = data.incomeExpenseType
        console.log(this.name, ' data.name')
        console.log(this.type, ' data.type')
        console.log(this.dateTime, 'data.dateTime')
        console.log(this.incomeExpenseType, 'data.incomeExpenseType')
        this.getBillAnalysis()
        this.getBillCategoryList()
      }
    },
    nextPages() {
      if (this.total <= this.list.length) {
        this.finished = true
        return;
      }
      this.pageNum = this.pageNum + 1
      this.loading = true
      this.getBillCategoryList()
    },
    getBillCategoryList() {
      getBillCategoryList({
        pageSize: this.pageSize,
        pageNum: this.pageNum,
        dateTime: this.dateTime,
        type: this.type,
        name: this.name,
        incomeExpenseType: this.incomeExpenseType
      }).then(res => {
        console.log(JSON.stringify(res), '列表')
        if (res.data.code === 200) {
          this.list = [...this.list, ...res.data.data.list]
          this.total = res.data.data.total
          this.expensesTotal = res.data.data.expensesTotal
          this.incomeTotal = res.data.data.incomeTotal
          this.loading = false
        } else {
          this.loading = false
          this.error = true
        }
      })
    },
    async init(data = {}) {
      // chart 图表实例不能存在data里
      let echartsDom = this.$refs.chartRef;
      this.chart = echarts.init(echartsDom)
      console.log(this.chart)
      let chart = this.chart
      this.bindChartEvents();
      chart.setOption(data)
    },
    bindChartEvents() {
      if (!this.chart) {
        console.error('Chart instance is not available.');
        return;
      }
      // 数据缩放变化事件
      // 移除之前的事件监听
      this.chart.off('datazoom');
      // 使用 datazoom 事件替代不存在的 datazoomended 事件
      this.chart.on('datazoom', this.handleDataZoom);
    },
    handleDataZoom(params) {
      // 使用防抖机制，确保只在最后一次触发后执行
      if (this.zoomTimer) {
        clearTimeout(this.zoomTimer);
      }
      this.zoomTimer = setTimeout(() => {
        this.handleDataZoomEnd(params);
      }, 300); // 300ms 的防抖延迟
    },
    handleDataZoomEnd(params) {
      // 滑动结束后触发
      console.log('滑动结束', params);
      // 在这里添加你需要执行的逻辑
      // 计算中间区域数据
      this.calculateCenterData();
    },
    calculateCenterData() {
      if (!this.chart) {
        console.warn('图表实例不存在');
        return;
      }
      try {
        // 获取当前图表配置
        const option = this.chart.getOption();
        // 获取数据长度
        const dataLength = this.chatData.dateTimeList?.length || 0;
        if (dataLength === 0) {
          console.warn('没有数据');
          return;
        }

        // 获取 dataZoom 配置
        const dataZoom = option.dataZoom && option.dataZoom[0];
        if (!dataZoom) {
          console.warn('没有找到 dataZoom 配置');
          return;
        }

        // 计算当前显示的数据范围
        let startIndex, endIndex;

        if (dataZoom.startValue !== undefined && dataZoom.endValue !== undefined) {
          // 基于索引的缩放
          startIndex = Math.max(0, dataZoom.startValue);
          endIndex = Math.min(dataLength - 1, dataZoom.endValue);
        } else {
          // 基于百分比的缩放
          const startRatio = (dataZoom.start || 0) / 100;
          const endRatio = (dataZoom.end || 100) / 100;
          startIndex = Math.floor(startRatio * dataLength);
          endIndex = Math.ceil(endRatio * dataLength);
        }

        console.log(`显示范围: ${startIndex} - ${endIndex}, 总数据: ${dataLength}`);

        // 计算中间位置
        const visibleCount = endIndex - startIndex;
        const middleIndex = Math.floor(startIndex + visibleCount / 2);

        // 确保索引在有效范围内
        const safeIndex = Math.max(0, Math.min(middleIndex, dataLength - 1));

        // 获取中间数据
        const centerData = {
          index: safeIndex,
          date: this.chatData.dateTimeList[safeIndex],
          value: this.incomeExpenseType == 1 ?
              this.chatData.incomeList[safeIndex] : this.chatData.expensesList[safeIndex],
          visibleRange: {
            start: startIndex,
            end: endIndex,
            count: visibleCount
          },
          timestamp: new Date().toISOString()
        };

        console.log('📊 屏幕中间区域数据:', centerData);

        // 触发事件或更新状态
        this.onCenterDataChanged(centerData);

      } catch (error) {
        console.error('计算中间数据失败:', error);
      }
    },
    onCenterDataChanged(centerData) {
      // 在这里处理中间数据变化的业务逻辑
      console.log('🎯 中间数据已更新:', {
        日期: centerData.date,
        数值: centerData.value,
        位置: `第 ${centerData.index + 1} 个数据`,
        显示范围: `${centerData.visibleRange.start + 1} - ${centerData.visibleRange.end + 1}`,
        可见数据点: centerData.visibleRange.count
      });
      let currentCenterData = this.trendList[centerData.index]

      // 2. 更新本地状态
      if (this.type == 0) {
        this.dateTime = currentCenterData.dateTime.slice(0, 7);
      } else {
        this.dateTime = currentCenterData.dateTime.slice(0, 4);
      }
      this.status = 'loading'
      this.pageNum = 1
      this.list = []
      this.getBillCategoryList()

      if (window.FlutterBridge) {
        window.FlutterBridge.postMessage({
          type: 'message',
          data: this.dateTime
        });
      }

    },
    getBillAnalysis() {
      billAnalysis({
        dateTime: this.dateTime,
        type: this.type
      }).then(res => {
        console.log(JSON.stringify(res), '图表')
        if (res.data.code === 200) {
          let trendList = res.data.data.trendList.reverse()
          let lastArr = trendList.slice(-3)
          trendList = [...trendList, ...lastArr]
          this.trendList = trendList
          const dataLength = this.trendList.length;
          const visiblePoints = 7;
          // 精确计算显示范围
          let startValue = 0;
          let endValue = dataLength - 1;

          if (dataLength > visiblePoints) {
            startValue = dataLength - visiblePoints;
            endValue = dataLength - 1;
          }
          const originalData = this.incomeExpenseType == 1 ?
              this.chatData.incomeList :
              this.chatData.expensesList;

          // 处理数据：最后三条设为null
          const processedData = [...originalData];
          for (let i = Math.max(0, dataLength - 3); i < dataLength; i++) {
            processedData[i] = null;
          }

          this.$nextTick(() => {
            this.init({
              grid: {
                top: remToPx(0.80),
                left: '0%',
                right: '0%',
                bottom: remToPx(0.1),
              },
              xAxis: {
                position: 'top', // 文字放在上面
                type: 'category',
                data: this.chatData.dateTimeList.map((date, index) =>
                    index >= dataLength - 3 ? '' : date
                ),
                boundaryGap: false, // 确保数据从左边开始
                axisLine: {
                  show: false, // 隐藏 X 轴线
                },
                axisTick: {
                  show: true, // 显示刻度线
                  alignWithLabel: true,
                  length: remToPx(2), // 刻度线长度
                  lineStyle: {
                    color: '#C5C4C9',
                    width: 1,
                    type: 'dashed' // 虚线刻度线
                  },
                  // 关键：隐藏最后三个刻度线
                  interval: (index) => {
                    return index < dataLength -
                        3; // 最后三个返回false，不显示刻度线
                  }
                },
              },
              yAxis: {
                type: 'value',
                show: false, // 隐藏Y轴
              },
              series: [{
                color: '#0D703E',
                data: processedData,
                type: 'line',
                smooth: true
              }],
              dataZoom: [{
                connectNulls: false, // 不连接null值，这样最后三条就没有连线
                type: 'inside', // 启用内部滑动
                xAxisIndex: [0], // 只作用于第一个 x 轴
                startValue: startValue, // 使用索引值更精确
                endValue: endValue,
                zoomLock: dataLength <= 7 // 锁定缩放，避免用户缩放影响滑动
              }]
            })
          })
        }
      })
    },
  }
}
</script>
<style lang="scss" scoped>
.list {
  width: 7.5rem;

  .item {
    display: flex;
    justify-content: space-between;
    padding: 0 .26rem 0 .30rem;
    box-sizing: border-box;
    color: #333;
    font-size: .24rem;
    margin-bottom: .5rem;

    .item-right {
      text-align: right;

      .item-amount {
        margin-bottom: .10rem;
        font-weight: 600;
      }
    }

    .item-left {
      .item-bank {
        color: #999999;
      }

      .item-name {
        font-size: .28rem;
        margin-bottom: .1rem;
      }
    }
  }

  .title {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: .4rem 0.2rem 0.4rem 0.3rem;
    box-sizing: border-box;
    color: #333333;
    border-bottom: 0.01rem solid #ccc;
    margin-bottom: 0.4rem;

    .title-left {
      font-size: 0.36rem;

      text {
        font-weight: 600;
      }
    }

    .title-right {
      display: flex;
      align-items: center;
      font-size: 0.28rem;

      .title-right-icon {
        width: 0.32rem;
        margin-left: 0.06rem;
        height: 0.32rem;
      }
    }
  }
}

.chat {
  width: 100%;
  background-color: #F6F5FA;
  height: 3.10rem;
  position: relative;

  .chart-content {
    width: 100%;
    height: 2.90rem;
  }

  &:before {
    width: 0;
    height: 0;
    border-left: 0.22rem solid transparent;
    border-right: 0.22rem solid transparent;
    border-bottom: 0.2rem solid #fff;
    content: '';
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    bottom: 0;
    z-index: 2;

  }

  .active {
    width: 1.50rem;
    height: 2.4rem;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    bottom: 0.3rem;
    background: linear-gradient(to bottom, rgba(13, 112, 62, 0) 0%, rgba(13, 112, 62, 0.3) 100%);

  }
}


</style>
