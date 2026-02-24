<template>
  <div class="content">
    <div class="page-one">
      <img class="page-image" :src="img1" alt=""></img>
      <div class="date" @click="handleShow">
        <span class="date-month">{{ computedMonth }}</span>
        <span>月/{{ computedYear }}</span>
      </div>
      <div class="total">
        <div class="total-item">{{ momneyStr(chartData.surplus.surplus) }}</div>
        <div class="total-item">{{ momneyStr(chartData.surplus.income) }}</div>
        <div class="total-item">{{ momneyStr(chartData.surplus.expenses) }}</div>
      </div>
      <div class="bar-chart">
        <barChart :chartData="chartData.surplus" @select="handleBarSelect" />
      </div>
    </div>
    <div class="page-two">
      <img class="page-image" :src="img2" alt=""></img>
      <div class="income-title">{{ computedMonth2 }}月收入</div>
      <div class="income-total">{{ momneyStr(chartData.income.totalAmount) }}</div>
    </div>
    <div class="page-content">
      <template v-if="chartData.income.dataList && chartData.income.dataList.length > 0">
        <div class="row" v-for="item in chartData.income.dataList" :key="item.categoryName">
          <div class="left">
            <img class="row-icon" :src="item.icon" />
            <span>{{ item.categoryName }}</span>
            <span class="number">{{ item.count }}笔</span>
          </div>
          <div class="right">{{ momneyStr(item.amount) }}</div>
        </div>
      </template>
      <template v-else>
        <div class="page-empty">
          <div class="page-empty-content">本月没有任何收入哦~</div>
        </div>
      </template>
    </div>
    <div class="page-three">
      <img class="page-image" :src="img3" alt=""></img>
      <div class="expenses-title">{{ computedMonth2 }}月支出</div>
      <div class="expenses-total">{{ momneyStr(chartData.elasticityExpenses.totalAmount) }}</div>
    </div>
    <div class="page-content">
      <template v-if="chartData.elasticityExpenses.dataList && chartData.elasticityExpenses.dataList.length > 0">
        <div class="row" v-for="item in chartData.elasticityExpenses.dataList" :key="item.categoryName">
          <div class="left">
            <img class="row-icon" :src="item.icon" />
            <span>{{ item.categoryName }}</span>
            <span class="number">{{ item.count }}笔</span>
          </div>
          <div class="right">{{ momneyStr(item.amount) }}</div>
        </div>
        <div class="line-chart">
          <lineChart :chartData="chartData.elasticityExpenses" />
        </div>
      </template>
      <template v-else>
        <div class="page-empty" style="padding-bottom: 0.6rem;">
          <div class="page-empty-content">本月没有任何弹性支出哦~</div>
        </div>
      </template>
    </div>
    <div class="page-four">
      <img class="page-image" :src="img4" alt=""></img>
      <div class="expenses-total">{{ momneyStr(chartData.demandExpenses.totalAmount) }}</div>
    </div>
    <div class="page-content">
      <template v-if="chartData.demandExpenses.dataList && chartData.demandExpenses.dataList.length > 0">
        <div class="item" v-for="item in chartData.demandExpenses.dataList" :key="item.id">
          <img class="row-icon" :src="item.icon" />
          <div class="info">
            <div class="info-title">
              <div class="name">{{ `${item.excerpt}-${item.merchantBranch}` }}</div>
              <span class="price">{{ momneyStr(item.amount) }}</span>
            </div>
            <div class="company">{{ item.oppositeName }}</div>
            <div class="desc">
              <span>{{ item.bankCard }}</span>
              <span>{{ item.transactionTime }}</span>
            </div>
          </div>
        </div>
        <div class="line-chart" style="margin-bottom: 0;">
          <lineChart :isTan="false" :chartData="chartData.demandExpenses" />
        </div>
      </template>
      <template v-else>
        <div class="page-empty">
          <div class="page-empty-content">本月没有任何刚性支出哦~</div>
        </div>
      </template>
    </div>
    <div class="page-five">
      <img class="page-image" :src="img5" alt=""></img>
    </div>
    <van-popup v-model="showPicker" :closeable="true" position="bottom">
      <div>
        <div class="pop-title">月度选择</div>
        <van-picker
          ref="pickerRef"
          :columns="columns"
          @cancel="showPicker = false"
          style="height: 200px; overflow: hidden;"
        />
        <div class="confim-button">
          <div class="confim-button-content" @click="handleConfim">确定</div>
        </div>
      </div>
    </van-popup>
  </div>
</template>

<script>
import img1 from '/src/assets/image/month-analysis-1.png';
import img2 from '/src/assets/image/month-analysis-2.png';
import img3 from '/src/assets/image/month-analysis-3.png';
import img4 from '/src/assets/image/month-analysis-4.png';
import img5 from '/src/assets/image/month-analysis-5.png';
import barChart from './barChart.vue';
import lineChart from './lineChart.vue';
import {getMonthAnalysisList, getMemberInfo} from "@/api";
import {formatAmount} from "@/utils";
import {mapState} from "vuex";

export default {
  components: {
    barChart,
    lineChart
  },
  data() {
    return {
      img1: img1,
      img2: img2,
      img3: img3,
      img4: img4,
      img5: img5,
      showPicker: false,
      columns: [], 
      dateTime: '',
      type: '', // 0月度 1年度
      chartData: {
        income: {},
        surplus: {},
        elasticityExpenses: {},
        demandExpenses: {},
      },
      formatAmount: formatAmount,
    };
  },
  computed: {
    ...mapState(['token']),
    momneyStr() {
      return (amount) => {
        if(!amount) {
          return '￥0.00';
        }
        let num = parseFloat(amount)
        if (num > 0) {
          return `￥${formatAmount(num.toFixed(2))}`
        } else {
          return `-￥${formatAmount(Math.abs(num).toFixed(2))}`
        }
      }
    },
     computedYear() {
      const date = new Date(this.dateTime + "-01");
      return date.getFullYear();
    },
    computedMonth() {
      const date = new Date(this.dateTime + "-01");
      return date.getMonth() + 1 > 9
        ? date.getMonth() + 1
        : `0${date.getMonth() + 1}`;
    },
    computedMonth2() {
      const date = new Date(this.dateTime + "-01");
      return date.getMonth() + 1;
    }
  },
  mounted() {
    // 监听Flutter传来的数据
    // window.addEventListener('flutter_onMessage', this.handleFlutterData);
    // let data = {name: '购物', type: 0, dateTime: '2025-12', incomeExpenseType: '2'}
    // this.name = data.name
    // this.type = data.type
    // this.dateTime = data.dateTime
    // this.incomeExpenseType = data.incomeExpenseType
    // console.log(this.dateTime)
    const date = new Date();
    const list = [];
    for(let i = 2000; i <= date.getFullYear(); i++) {
      list.push(`${i}年`);
    }
    this.columns.push({ values: list, className: 'column1' });
    const list2 = [];
    for(let i = 1; i <= 12; i++) {
      if(i < 10) {
        list2.push(`0${i}月`);
      }else{
        list2.push(`${i}月`);
      }
    }
    this.columns.push({ values: list2, className: 'column2' });

    const lastMonth = new Date(date);
    lastMonth.setMonth(date.getMonth() - 1);
    const tempMonth = lastMonth.getMonth() + 1 > 9 ? lastMonth.getMonth() + 1:`0${lastMonth.getMonth() + 1}`;
    const dateTime = `${lastMonth.getFullYear()}-${tempMonth}`

    this.handleFlutterData({ detail: { dateTime: dateTime } });
  },
  methods: {
    handleFlutterData(event) {
      if (event.detail) {
        let data = event.detail;
        this.dateTime = data.dateTime;
        this.type = data.type;
        this.getList()
      }
    },
    handleShow() {
      this.showPicker = true;
      this.$nextTick(() => {
        const list = this.dateTime.split('-').map((item,index) => {
          if(index == 0) {
            return `${item}年`;
          }else{
            return `${item}月`;
          }
        });
        this.$refs.pickerRef.setValues(list);
      })
    },
    handleConfim() {
      const list = this.$refs.pickerRef.getValues();
      this.dateTime = list.map(item => item.substring(0, item.length - 1)).join('-');
      this.showPicker = false;
      this.getList();
    },
    handleBarSelect(data) {
      const dateTime = data.year.substring(0, data.year.length - 1) + '-' + data.oldMonth.substring(0, data.oldMonth.length - 1);
      this.getInfo(dateTime);
    },
    getInfo(dateTime) {
      getMonthAnalysisList({
        dateTime: dateTime,
      }).then(res => {
        if (res.data.code === 200) {
          this.chartData.surplus.surplus = res.data.data.surplus.surplus;
          this.chartData.surplus.income = res.data.data.surplus.income;
          this.chartData.surplus.expenses = res.data.data.surplus.expenses;
        } 
      })
    },
    getList() {
      getMonthAnalysisList({
        dateTime: this.dateTime,
      }).then(res => {
        if (res.data.code === 200) {
          const index = res.data.data.surplus.surplusChartList.findIndex(item => item.month == '12月');
          res.data.data.surplus.surplusChartList.forEach((item,idx) => {
            item.oldMonth = item.month;
            if(index != -1) {
              if(index == 0) {
                item.month = `${this.computedYear}年`.substring(2,5);
                item.year = `${this.computedYear}年`;
              }else{
                if(idx < index) {
                  item.year = `${this.computedYear}年`;
                }else{
                  item.year = `${this.computedYear - 1}年`;
                }
              }
            }else{
              item.year = `${this.computedYear}年`;
            }
          });
          this.chartData = res.data.data;
          console.log(this.chartData, 'this.chartData');
        } 
      })
    },
  }
};
</script>

<style lang="scss" scoped>
.content {
  background-color: #fff;
}
.page-image {
  width: 100%;
  height: 100%;
  display: flex;
}
.page-content {
  margin: 0 calc(33 / 1080 * 100vw);
  border-left: calc(35 / 1080 * 100vw) outset #e9f7fc;
  border-right: calc(35 / 1080 * 100vw) inset #e9f7fc;
  padding-bottom: 0.2rem;
  box-sizing: border-box;
}
.income-title {
  text-align: center;
  font-size: .3rem;
  position: absolute;
  top: 0.86rem;
  width: 100vw;
}
.income-total {
  font-size: .3rem;
  position: absolute;
  bottom: 0.15rem;
  right: calc(110 / 1080 * 100vw);
}
.expenses-title {
  text-align: center;
  font-size: .3rem;
  position: absolute;
  top: 1.2rem;
  width: 100vw;
}
.expenses-total {
  font-size: .3rem;
  position: absolute;
  bottom: 0.15rem;
  right: calc(110 / 1080 * 100vw);
}
.row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: .26rem;
  padding: 0 calc(46 / 1080 * 100vw);
  padding-top: 0.4rem;
  // font-weight: 300;
}
.left {
  display: flex;
  align-items: center;
  gap: 0.2rem;
}
.row-icon {
  width: 0.4rem;
  height: 0.4rem;
  color: #999999;
}
.number {
  font-size: .24rem;
  color: #999999;
}
.tag {
  font-size: .20rem;
  color: #ef8460;
  border: 0.1px solid #ef8460;
  padding: 2px 4px;
}
.right {
  display: flex;
  align-items: center;
}
.line-chart {
  height: 3rem;
  background-color: #F7F6FB;
  border-radius: 0.2rem;
  margin: 0.2rem calc(46 / 1080 * 100vw) 0.4rem;
}
.bar-chart {
  position: absolute;
  width: calc(800 / 1080 * 100vw);
  height: 4.7rem;
  bottom: 0.5rem;
  left: calc(140 / 1080 * 100vw);
}
.date {
  position: absolute;
  left: calc(80 / 1080 * 100vw);
  top: 0;
  height: 1.5rem;
  width: 1.8rem;
  font-size: 0.28rem;
  display: flex;
  justify-content: right;
  align-items: center;
  color: #999999;
}
.date-month {
  font-size: 0.7rem;
  color: #000000;
  margin-top: -0.25rem;
}
.total {
  position: absolute;
  top: 2.4rem;
  left: calc(70 / 1080 * 100vw);
  width: calc(980 / 1080 * 100vw);
  font-size: 0.24rem;
  height: 0.6rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.total-item {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
}
.item {
  display: flex;
  font-size: .26rem;
  padding: 0 calc(46 / 1080 * 100vw);
  padding-top: 0.6rem;
  box-sizing: border-box;
}
.info {
  width: calc(100% - 0.4rem);
  padding-left: 0.2rem;
  box-sizing: border-box;
}
.info-title {
  display: flex;
  justify-content: space-between;
  gap: 0.5rem;
  font-size: 0.26rem;
}
.name {
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
  // width: 50vw;
}
.company {
  margin-top: 0.15rem;
  font-size: 0.24rem;
}
.desc {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 0.15rem;
  font-size: 0.24rem;
  color: #999999;
}
.price {
  flex-shrink: 0;
}
.page-empty {
  padding-top: 0.3rem;
}
.page-empty-content {
  height: 1.3rem;
  background-color: #F7F6FB;
  border-radius: 0.2rem;
  width: calc(852 / 1080 * 100vw);
  margin: 0 auto;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 0.24rem;
  color: #999999;
}
.page-one {
  width: 100vw;
  position: relative;
  // aspect-ratio: 1080/1217;
}
.page-two {
  width: 100vw;
  position: relative;
  // aspect-ratio: 1080/364;
}
.page-three {
  width: 100vw;
  position: relative;
  // aspect-ratio: 1080/415;
}
.page-four {
  width: 100vw;
  position: relative;
  // aspect-ratio: 1080/100;
}
.page-five {
  width: 100vw;
  // aspect-ratio: 1080/105;
}
.pop-title{
  text-align: center;
  font-size: 0.35rem;
  padding-top: 20px;
}
.confim-button {
  padding: 5px 15px;
}
.confim-button-content {
  background-color: green;
  color: #fff;
  font-size: 0.4rem;
  width: 100%;
  border-radius: 15px;
  height: 50px;
  z-index: 1;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
