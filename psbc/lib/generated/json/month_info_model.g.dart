import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/month_info_model.dart';

MonthInfoModel $MonthInfoModelFromJson(Map<String, dynamic> json) {
  final MonthInfoModel monthInfoModel = MonthInfoModel();
  final double? totalAmount = jsonConvert.convert<double>(json['totalAmount']);
  if (totalAmount != null) {
    monthInfoModel.totalAmount = totalAmount;
  }
  final double? upTotalAmount = jsonConvert.convert<double>(
      json['upTotalAmount']);
  if (upTotalAmount != null) {
    monthInfoModel.upTotalAmount = upTotalAmount;
  }
  final double? flexibleAmount = jsonConvert.convert<double>(
      json['flexibleAmount']);
  if (flexibleAmount != null) {
    monthInfoModel.flexibleAmount = flexibleAmount;
  }
  final double? investmentAmount = jsonConvert.convert<double>(
      json['investmentAmount']);
  if (investmentAmount != null) {
    monthInfoModel.investmentAmount = investmentAmount;
  }
  final MonthInfoIncomeExpenseAnalysis? incomeExpenseAnalysis = jsonConvert
      .convert<MonthInfoIncomeExpenseAnalysis>(json['incomeExpenseAnalysis']);
  if (incomeExpenseAnalysis != null) {
    monthInfoModel.incomeExpenseAnalysis = incomeExpenseAnalysis;
  }
  return monthInfoModel;
}

Map<String, dynamic> $MonthInfoModelToJson(MonthInfoModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['totalAmount'] = entity.totalAmount;
  data['upTotalAmount'] = entity.upTotalAmount;
  data['flexibleAmount'] = entity.flexibleAmount;
  data['investmentAmount'] = entity.investmentAmount;
  data['incomeExpenseAnalysis'] = entity.incomeExpenseAnalysis.toJson();
  return data;
}

extension MonthInfoModelExtension on MonthInfoModel {
  MonthInfoModel copyWith({
    double? totalAmount,
    double? upTotalAmount,
    double? flexibleAmount,
    double? investmentAmount,
    MonthInfoIncomeExpenseAnalysis? incomeExpenseAnalysis,
  }) {
    return MonthInfoModel()
      ..totalAmount = totalAmount ?? this.totalAmount
      ..upTotalAmount = upTotalAmount ?? this.upTotalAmount
      ..flexibleAmount = flexibleAmount ?? this.flexibleAmount
      ..investmentAmount = investmentAmount ?? this.investmentAmount
      ..incomeExpenseAnalysis = incomeExpenseAnalysis ??
          this.incomeExpenseAnalysis;
  }
}

MonthInfoIncomeExpenseAnalysis $MonthInfoIncomeExpenseAnalysisFromJson(
    Map<String, dynamic> json) {
  final MonthInfoIncomeExpenseAnalysis monthInfoIncomeExpenseAnalysis = MonthInfoIncomeExpenseAnalysis();
  final List<
      MonthInfoIncomeExpenseAnalysisTrend>? trend = (json['trend'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MonthInfoIncomeExpenseAnalysisTrend>(
          e) as MonthInfoIncomeExpenseAnalysisTrend).toList();
  if (trend != null) {
    monthInfoIncomeExpenseAnalysis.trend = trend;
  }
  final double? income = jsonConvert.convert<double>(json['income']);
  if (income != null) {
    monthInfoIncomeExpenseAnalysis.income = income;
  }
  final double? expenses = jsonConvert.convert<double>(json['expenses']);
  if (expenses != null) {
    monthInfoIncomeExpenseAnalysis.expenses = expenses;
  }
  final double? cashSurplus = jsonConvert.convert<double>(json['cashSurplus']);
  if (cashSurplus != null) {
    monthInfoIncomeExpenseAnalysis.cashSurplus = cashSurplus;
  }
  final List<
      MonthInfoIncomeExpenseAnalysisIncomeList>? incomeList = (json['incomeList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MonthInfoIncomeExpenseAnalysisIncomeList>(
          e) as MonthInfoIncomeExpenseAnalysisIncomeList).toList();
  if (incomeList != null) {
    monthInfoIncomeExpenseAnalysis.incomeList = incomeList;
  }
  final List<
      MonthInfoIncomeExpenseAnalysisExpensesList>? expensesList = (json['expensesList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<MonthInfoIncomeExpenseAnalysisExpensesList>(
          e) as MonthInfoIncomeExpenseAnalysisExpensesList).toList();
  if (expensesList != null) {
    monthInfoIncomeExpenseAnalysis.expensesList = expensesList;
  }
  return monthInfoIncomeExpenseAnalysis;
}

Map<String, dynamic> $MonthInfoIncomeExpenseAnalysisToJson(
    MonthInfoIncomeExpenseAnalysis entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['trend'] = entity.trend.map((v) => v.toJson()).toList();
  data['income'] = entity.income;
  data['expenses'] = entity.expenses;
  data['cashSurplus'] = entity.cashSurplus;
  data['incomeList'] = entity.incomeList.map((v) => v.toJson()).toList();
  data['expensesList'] = entity.expensesList.map((v) => v.toJson()).toList();
  return data;
}

extension MonthInfoIncomeExpenseAnalysisExtension on MonthInfoIncomeExpenseAnalysis {
  MonthInfoIncomeExpenseAnalysis copyWith({
    List<MonthInfoIncomeExpenseAnalysisTrend>? trend,
    double? income,
    double? expenses,
    double? cashSurplus,
    List<MonthInfoIncomeExpenseAnalysisIncomeList>? incomeList,
    List<MonthInfoIncomeExpenseAnalysisExpensesList>? expensesList,
  }) {
    return MonthInfoIncomeExpenseAnalysis()
      ..trend = trend ?? this.trend
      ..income = income ?? this.income
      ..expenses = expenses ?? this.expenses
      ..cashSurplus = cashSurplus ?? this.cashSurplus
      ..incomeList = incomeList ?? this.incomeList
      ..expensesList = expensesList ?? this.expensesList;
  }
}

MonthInfoIncomeExpenseAnalysisTrend $MonthInfoIncomeExpenseAnalysisTrendFromJson(
    Map<String, dynamic> json) {
  final MonthInfoIncomeExpenseAnalysisTrend monthInfoIncomeExpenseAnalysisTrend = MonthInfoIncomeExpenseAnalysisTrend();
  final double? income = jsonConvert.convert<double>(json['income']);
  if (income != null) {
    monthInfoIncomeExpenseAnalysisTrend.income = income;
  }
  final double? expenses = jsonConvert.convert<double>(json['expenses']);
  if (expenses != null) {
    monthInfoIncomeExpenseAnalysisTrend.expenses = expenses;
  }
  final String? dateTime = jsonConvert.convert<String>(json['dateTime']);
  if (dateTime != null) {
    monthInfoIncomeExpenseAnalysisTrend.dateTime = dateTime;
  }
  return monthInfoIncomeExpenseAnalysisTrend;
}

Map<String, dynamic> $MonthInfoIncomeExpenseAnalysisTrendToJson(
    MonthInfoIncomeExpenseAnalysisTrend entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['income'] = entity.income;
  data['expenses'] = entity.expenses;
  data['dateTime'] = entity.dateTime;
  return data;
}

extension MonthInfoIncomeExpenseAnalysisTrendExtension on MonthInfoIncomeExpenseAnalysisTrend {
  MonthInfoIncomeExpenseAnalysisTrend copyWith({
    double? income,
    double? expenses,
    String? dateTime,
  }) {
    return MonthInfoIncomeExpenseAnalysisTrend()
      ..income = income ?? this.income
      ..expenses = expenses ?? this.expenses
      ..dateTime = dateTime ?? this.dateTime;
  }
}

MonthInfoIncomeExpenseAnalysisIncomeList $MonthInfoIncomeExpenseAnalysisIncomeListFromJson(
    Map<String, dynamic> json) {
  final MonthInfoIncomeExpenseAnalysisIncomeList monthInfoIncomeExpenseAnalysisIncomeList = MonthInfoIncomeExpenseAnalysisIncomeList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    monthInfoIncomeExpenseAnalysisIncomeList.name = name;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    monthInfoIncomeExpenseAnalysisIncomeList.amount = amount;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    monthInfoIncomeExpenseAnalysisIncomeList.id = id;
  }
  return monthInfoIncomeExpenseAnalysisIncomeList;
}

Map<String, dynamic> $MonthInfoIncomeExpenseAnalysisIncomeListToJson(
    MonthInfoIncomeExpenseAnalysisIncomeList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['amount'] = entity.amount;
  data['id'] = entity.id;
  return data;
}

extension MonthInfoIncomeExpenseAnalysisIncomeListExtension on MonthInfoIncomeExpenseAnalysisIncomeList {
  MonthInfoIncomeExpenseAnalysisIncomeList copyWith({
    String? name,
    double? amount,
    int? id,
  }) {
    return MonthInfoIncomeExpenseAnalysisIncomeList()
      ..name = name ?? this.name
      ..amount = amount ?? this.amount
      ..id = id ?? this.id;
  }
}

MonthInfoIncomeExpenseAnalysisExpensesList $MonthInfoIncomeExpenseAnalysisExpensesListFromJson(
    Map<String, dynamic> json) {
  final MonthInfoIncomeExpenseAnalysisExpensesList monthInfoIncomeExpenseAnalysisExpensesList = MonthInfoIncomeExpenseAnalysisExpensesList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    monthInfoIncomeExpenseAnalysisExpensesList.name = name;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    monthInfoIncomeExpenseAnalysisExpensesList.amount = amount;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    monthInfoIncomeExpenseAnalysisExpensesList.id = id;
  }
  return monthInfoIncomeExpenseAnalysisExpensesList;
}

Map<String, dynamic> $MonthInfoIncomeExpenseAnalysisExpensesListToJson(
    MonthInfoIncomeExpenseAnalysisExpensesList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['amount'] = entity.amount;
  data['id'] = entity.id;
  return data;
}

extension MonthInfoIncomeExpenseAnalysisExpensesListExtension on MonthInfoIncomeExpenseAnalysisExpensesList {
  MonthInfoIncomeExpenseAnalysisExpensesList copyWith({
    String? name,
    double? amount,
    int? id,
  }) {
    return MonthInfoIncomeExpenseAnalysisExpensesList()
      ..name = name ?? this.name
      ..amount = amount ?? this.amount
      ..id = id ?? this.id;
  }
}