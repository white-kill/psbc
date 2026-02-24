import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/year_bill_info_model.dart';

YearBillInfoModel $YearBillInfoModelFromJson(Map<String, dynamic> json) {
  final YearBillInfoModel yearBillInfoModel = YearBillInfoModel();
  final String? expensesMaxDateTime = jsonConvert.convert<String>(
      json['expensesMaxDateTime']);
  if (expensesMaxDateTime != null) {
    yearBillInfoModel.expensesMaxDateTime = expensesMaxDateTime;
  }
  final int? year = jsonConvert.convert<int>(json['year']);
  if (year != null) {
    yearBillInfoModel.year = year;
  }
  final String? daysDeparture = jsonConvert.convert<String>(
      json['daysDeparture']);
  if (daysDeparture != null) {
    yearBillInfoModel.daysDeparture = daysDeparture;
  }
  final double? totalExpenses = jsonConvert.convert<double>(
      json['totalExpenses']);
  if (totalExpenses != null) {
    yearBillInfoModel.totalExpenses = totalExpenses;
  }
  final double? monthCount = jsonConvert.convert<double>(json['monthCount']);
  if (monthCount != null) {
    yearBillInfoModel.monthCount = monthCount;
  }
  final String? jtcx = jsonConvert.convert<String>(json['jtcx']);
  if (jtcx != null) {
    yearBillInfoModel.jtcx = jtcx;
  }
  final double? oldYearEndbalance = jsonConvert.convert<double>(
      json['oldYearEndbalance']);
  if (oldYearEndbalance != null) {
    yearBillInfoModel.oldYearEndbalance = oldYearEndbalance;
  }
  final String? incomeMaxDateTime = jsonConvert.convert<String>(
      json['incomeMaxDateTime']);
  if (incomeMaxDateTime != null) {
    yearBillInfoModel.incomeMaxDateTime = incomeMaxDateTime;
  }
  final double? cymsMaxAmount = jsonConvert.convert<double>(
      json['cymsMaxAmount']);
  if (cymsMaxAmount != null) {
    yearBillInfoModel.cymsMaxAmount = cymsMaxAmount;
  }
  final List<
      YearBillInfoCategoryList>? categoryList = (json['categoryList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<YearBillInfoCategoryList>(
          e) as YearBillInfoCategoryList).toList();
  if (categoryList != null) {
    yearBillInfoModel.categoryList = categoryList;
  }
  final int? incomeCount = jsonConvert.convert<int>(json['incomeCount']);
  if (incomeCount != null) {
    yearBillInfoModel.incomeCount = incomeCount;
  }
  final double? yearSurplus = jsonConvert.convert<double>(json['yearSurplus']);
  if (yearSurplus != null) {
    yearBillInfoModel.yearSurplus = yearSurplus;
  }
  final double? yearEndbalance = jsonConvert.convert<double>(
      json['yearEndbalance']);
  if (yearEndbalance != null) {
    yearBillInfoModel.yearEndbalance = yearEndbalance;
  }
  final String? nightTime = jsonConvert.convert<String>(json['nightTime']);
  if (nightTime != null) {
    yearBillInfoModel.nightTime = nightTime;
  }
  final double? expensesLastYear = jsonConvert.convert<double>(
      json['expensesLastYear']);
  if (expensesLastYear != null) {
    yearBillInfoModel.expensesLastYear = expensesLastYear;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    yearBillInfoModel.count = count;
  }
  final double? expensesMaxAmount = jsonConvert.convert<double>(
      json['expensesMaxAmount']);
  if (expensesMaxAmount != null) {
    yearBillInfoModel.expensesMaxAmount = expensesMaxAmount;
  }
  final String? cymsTime = jsonConvert.convert<String>(json['cymsTime']);
  if (cymsTime != null) {
    yearBillInfoModel.cymsTime = cymsTime;
  }
  final String? medalNum = jsonConvert.convert<String>(json['medalNum']);
  if (medalNum != null) {
    yearBillInfoModel.medalNum = medalNum;
  }
  final String? medalList = jsonConvert.convert<String>(json['medalList']);
  if (medalList != null) {
    yearBillInfoModel.medalList = medalList;
  }
  final int? expensesCount = jsonConvert.convert<int>(json['expensesCount']);
  if (expensesCount != null) {
    yearBillInfoModel.expensesCount = expensesCount;
  }
  final double? totalIncome = jsonConvert.convert<double>(json['totalIncome']);
  if (totalIncome != null) {
    yearBillInfoModel.totalIncome = totalIncome;
  }
  final String? cyms = jsonConvert.convert<String>(json['cyms']);
  if (cyms != null) {
    yearBillInfoModel.cyms = cyms;
  }
  final String? timePeriod = jsonConvert.convert<String>(json['timePeriod']);
  if (timePeriod != null) {
    yearBillInfoModel.timePeriod = timePeriod;
  }
  final int? days = jsonConvert.convert<int>(json['days']);
  if (days != null) {
    yearBillInfoModel.days = days;
  }
  final double? incomeLastYear = jsonConvert.convert<double>(
      json['incomeLastYear']);
  if (incomeLastYear != null) {
    yearBillInfoModel.incomeLastYear = incomeLastYear;
  }
  final double? incomeMaxAmount = jsonConvert.convert<double>(
      json['incomeMaxAmount']);
  if (incomeMaxAmount != null) {
    yearBillInfoModel.incomeMaxAmount = incomeMaxAmount;
  }
  return yearBillInfoModel;
}

Map<String, dynamic> $YearBillInfoModelToJson(YearBillInfoModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['expensesMaxDateTime'] = entity.expensesMaxDateTime;
  data['year'] = entity.year;
  data['daysDeparture'] = entity.daysDeparture;
  data['totalExpenses'] = entity.totalExpenses;
  data['monthCount'] = entity.monthCount;
  data['jtcx'] = entity.jtcx;
  data['oldYearEndbalance'] = entity.oldYearEndbalance;
  data['incomeMaxDateTime'] = entity.incomeMaxDateTime;
  data['cymsMaxAmount'] = entity.cymsMaxAmount;
  data['categoryList'] = entity.categoryList.map((v) => v.toJson()).toList();
  data['incomeCount'] = entity.incomeCount;
  data['yearSurplus'] = entity.yearSurplus;
  data['yearEndbalance'] = entity.yearEndbalance;
  data['nightTime'] = entity.nightTime;
  data['expensesLastYear'] = entity.expensesLastYear;
  data['count'] = entity.count;
  data['expensesMaxAmount'] = entity.expensesMaxAmount;
  data['cymsTime'] = entity.cymsTime;
  data['medalNum'] = entity.medalNum;
  data['medalList'] = entity.medalList;
  data['expensesCount'] = entity.expensesCount;
  data['totalIncome'] = entity.totalIncome;
  data['cyms'] = entity.cyms;
  data['timePeriod'] = entity.timePeriod;
  data['days'] = entity.days;
  data['incomeLastYear'] = entity.incomeLastYear;
  data['incomeMaxAmount'] = entity.incomeMaxAmount;
  return data;
}

extension YearBillInfoModelExtension on YearBillInfoModel {
  YearBillInfoModel copyWith({
    String? expensesMaxDateTime,
    int? year,
    String? daysDeparture,
    double? totalExpenses,
    double? monthCount,
    String? jtcx,
    double? oldYearEndbalance,
    String? incomeMaxDateTime,
    double? cymsMaxAmount,
    List<YearBillInfoCategoryList>? categoryList,
    int? incomeCount,
    double? yearSurplus,
    double? yearEndbalance,
    String? nightTime,
    double? expensesLastYear,
    int? count,
    double? expensesMaxAmount,
    String? cymsTime,
    String? medalNum,
    String? medalList,
    int? expensesCount,
    double? totalIncome,
    String? cyms,
    String? timePeriod,
    int? days,
    double? incomeLastYear,
    double? incomeMaxAmount,
  }) {
    return YearBillInfoModel()
      ..expensesMaxDateTime = expensesMaxDateTime ?? this.expensesMaxDateTime
      ..year = year ?? this.year
      ..daysDeparture = daysDeparture ?? this.daysDeparture
      ..totalExpenses = totalExpenses ?? this.totalExpenses
      ..monthCount = monthCount ?? this.monthCount
      ..jtcx = jtcx ?? this.jtcx
      ..oldYearEndbalance = oldYearEndbalance ?? this.oldYearEndbalance
      ..incomeMaxDateTime = incomeMaxDateTime ?? this.incomeMaxDateTime
      ..cymsMaxAmount = cymsMaxAmount ?? this.cymsMaxAmount
      ..categoryList = categoryList ?? this.categoryList
      ..incomeCount = incomeCount ?? this.incomeCount
      ..yearSurplus = yearSurplus ?? this.yearSurplus
      ..yearEndbalance = yearEndbalance ?? this.yearEndbalance
      ..nightTime = nightTime ?? this.nightTime
      ..expensesLastYear = expensesLastYear ?? this.expensesLastYear
      ..count = count ?? this.count
      ..expensesMaxAmount = expensesMaxAmount ?? this.expensesMaxAmount
      ..cymsTime = cymsTime ?? this.cymsTime
      ..medalNum = medalNum ?? this.medalNum
      ..medalList = medalList ?? this.medalList
      ..expensesCount = expensesCount ?? this.expensesCount
      ..totalIncome = totalIncome ?? this.totalIncome
      ..cyms = cyms ?? this.cyms
      ..timePeriod = timePeriod ?? this.timePeriod
      ..days = days ?? this.days
      ..incomeLastYear = incomeLastYear ?? this.incomeLastYear
      ..incomeMaxAmount = incomeMaxAmount ?? this.incomeMaxAmount;
  }
}

YearBillInfoCategoryList $YearBillInfoCategoryListFromJson(
    Map<String, dynamic> json) {
  final YearBillInfoCategoryList yearBillInfoCategoryList = YearBillInfoCategoryList();
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    yearBillInfoCategoryList.amount = amount;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    yearBillInfoCategoryList.category = category;
  }
  return yearBillInfoCategoryList;
}

Map<String, dynamic> $YearBillInfoCategoryListToJson(
    YearBillInfoCategoryList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['amount'] = entity.amount;
  data['category'] = entity.category;
  return data;
}

extension YearBillInfoCategoryListExtension on YearBillInfoCategoryList {
  YearBillInfoCategoryList copyWith({
    double? amount,
    String? category,
  }) {
    return YearBillInfoCategoryList()
      ..amount = amount ?? this.amount
      ..category = category ?? this.category;
  }
}