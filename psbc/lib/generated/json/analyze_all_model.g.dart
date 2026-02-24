import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/analyze_all_model.dart';

AnalyzeAllModel $AnalyzeAllModelFromJson(Map<String, dynamic> json) {
  final AnalyzeAllModel analyzeAllModel = AnalyzeAllModel();
  final double? income = jsonConvert.convert<double>(json['income']);
  if (income != null) {
    analyzeAllModel.income = income;
  }
  final double? expenses = jsonConvert.convert<double>(json['expenses']);
  if (expenses != null) {
    analyzeAllModel.expenses = expenses;
  }
  final double? cashSurplus = jsonConvert.convert<double>(json['cashSurplus']);
  if (cashSurplus != null) {
    analyzeAllModel.cashSurplus = cashSurplus;
  }
  final List<AnalyzeAllTrendList>? trendList = (json['trendList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<AnalyzeAllTrendList>(e) as AnalyzeAllTrendList)
      .toList();
  if (trendList != null) {
    analyzeAllModel.trendList = trendList;
  }
  final List<
      AnalyzeAllCateogryList>? incomeCateogryList = (json['incomeCateogryList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<AnalyzeAllCateogryList>(e) as AnalyzeAllCateogryList)
      .toList();
  if (incomeCateogryList != null) {
    analyzeAllModel.incomeCateogryList = incomeCateogryList;
  }
  final List<
      AnalyzeAllCateogryList>? expensesCateogryList = (json['expensesCateogryList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<AnalyzeAllCateogryList>(e) as AnalyzeAllCateogryList)
      .toList();
  if (expensesCateogryList != null) {
    analyzeAllModel.expensesCateogryList = expensesCateogryList;
  }
  final List<
      AnalyzeRankList>? expensesRankList = (json['expensesRankList'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<AnalyzeRankList>(e) as AnalyzeRankList)
      .toList();
  if (expensesRankList != null) {
    analyzeAllModel.expensesRankList = expensesRankList;
  }
  final List<AnalyzeRankList>? incomeRankList = (json['incomeRankList'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<AnalyzeRankList>(e) as AnalyzeRankList)
      .toList();
  if (incomeRankList != null) {
    analyzeAllModel.incomeRankList = incomeRankList;
  }
  return analyzeAllModel;
}

Map<String, dynamic> $AnalyzeAllModelToJson(AnalyzeAllModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['income'] = entity.income;
  data['expenses'] = entity.expenses;
  data['cashSurplus'] = entity.cashSurplus;
  data['trendList'] = entity.trendList.map((v) => v.toJson()).toList();
  data['incomeCateogryList'] =
      entity.incomeCateogryList.map((v) => v.toJson()).toList();
  data['expensesCateogryList'] =
      entity.expensesCateogryList.map((v) => v.toJson()).toList();
  data['expensesRankList'] =
      entity.expensesRankList.map((v) => v.toJson()).toList();
  data['incomeRankList'] =
      entity.incomeRankList.map((v) => v.toJson()).toList();
  return data;
}

extension AnalyzeAllModelExtension on AnalyzeAllModel {
  AnalyzeAllModel copyWith({
    double? income,
    double? expenses,
    double? cashSurplus,
    List<AnalyzeAllTrendList>? trendList,
    List<AnalyzeAllCateogryList>? incomeCateogryList,
    List<AnalyzeAllCateogryList>? expensesCateogryList,
    List<AnalyzeRankList>? expensesRankList,
    List<AnalyzeRankList>? incomeRankList,
  }) {
    return AnalyzeAllModel()
      ..income = income ?? this.income
      ..expenses = expenses ?? this.expenses
      ..cashSurplus = cashSurplus ?? this.cashSurplus
      ..trendList = trendList ?? this.trendList
      ..incomeCateogryList = incomeCateogryList ?? this.incomeCateogryList
      ..expensesCateogryList = expensesCateogryList ?? this.expensesCateogryList
      ..expensesRankList = expensesRankList ?? this.expensesRankList
      ..incomeRankList = incomeRankList ?? this.incomeRankList;
  }
}

AnalyzeAllTrendList $AnalyzeAllTrendListFromJson(Map<String, dynamic> json) {
  final AnalyzeAllTrendList analyzeAllTrendList = AnalyzeAllTrendList();
  final double? income = jsonConvert.convert<double>(json['income']);
  if (income != null) {
    analyzeAllTrendList.income = income;
  }
  final double? expenses = jsonConvert.convert<double>(json['expenses']);
  if (expenses != null) {
    analyzeAllTrendList.expenses = expenses;
  }
  final String? dateTime = jsonConvert.convert<String>(json['dateTime']);
  if (dateTime != null) {
    analyzeAllTrendList.dateTime = dateTime;
  }
  return analyzeAllTrendList;
}

Map<String, dynamic> $AnalyzeAllTrendListToJson(AnalyzeAllTrendList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['income'] = entity.income;
  data['expenses'] = entity.expenses;
  data['dateTime'] = entity.dateTime;
  return data;
}

extension AnalyzeAllTrendListExtension on AnalyzeAllTrendList {
  AnalyzeAllTrendList copyWith({
    double? income,
    double? expenses,
    String? dateTime,
  }) {
    return AnalyzeAllTrendList()
      ..income = income ?? this.income
      ..expenses = expenses ?? this.expenses
      ..dateTime = dateTime ?? this.dateTime;
  }
}

AnalyzeAllCateogryList $AnalyzeAllCateogryListFromJson(
    Map<String, dynamic> json) {
  final AnalyzeAllCateogryList analyzeAllCateogryList = AnalyzeAllCateogryList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    analyzeAllCateogryList.name = name;
  }
  final double? totalAmount = jsonConvert.convert<double>(json['totalAmount']);
  if (totalAmount != null) {
    analyzeAllCateogryList.totalAmount = totalAmount;
  }
  final String? categoryIcon = jsonConvert.convert<String>(
      json['categoryIcon']);
  if (categoryIcon != null) {
    analyzeAllCateogryList.categoryIcon = categoryIcon;
  }
  final double? upTotalAmount = jsonConvert.convert<double>(
      json['upTotalAmount']);
  if (upTotalAmount != null) {
    analyzeAllCateogryList.upTotalAmount = upTotalAmount;
  }
  final String? count = jsonConvert.convert<String>(json['count']);
  if (count != null) {
    analyzeAllCateogryList.count = count;
  }
  final double? rate = jsonConvert.convert<double>(json['rate']);
  if (rate != null) {
    analyzeAllCateogryList.rate = rate;
  }
  return analyzeAllCateogryList;
}

Map<String, dynamic> $AnalyzeAllCateogryListToJson(
    AnalyzeAllCateogryList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['totalAmount'] = entity.totalAmount;
  data['categoryIcon'] = entity.categoryIcon;
  data['upTotalAmount'] = entity.upTotalAmount;
  data['count'] = entity.count;
  data['rate'] = entity.rate;
  return data;
}

extension AnalyzeAllCateogryListExtension on AnalyzeAllCateogryList {
  AnalyzeAllCateogryList copyWith({
    String? name,
    double? totalAmount,
    String? categoryIcon,
    double? upTotalAmount,
    String? count,
    double? rate,
  }) {
    return AnalyzeAllCateogryList()
      ..name = name ?? this.name
      ..totalAmount = totalAmount ?? this.totalAmount
      ..categoryIcon = categoryIcon ?? this.categoryIcon
      ..upTotalAmount = upTotalAmount ?? this.upTotalAmount
      ..count = count ?? this.count
      ..rate = rate ?? this.rate;
  }
}

AnalyzeAllIncomeCateogryList $AnalyzeAllIncomeCateogryListFromJson(
    Map<String, dynamic> json) {
  final AnalyzeAllIncomeCateogryList analyzeAllIncomeCateogryList = AnalyzeAllIncomeCateogryList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    analyzeAllIncomeCateogryList.name = name;
  }
  final double? totalAmount = jsonConvert.convert<double>(json['totalAmount']);
  if (totalAmount != null) {
    analyzeAllIncomeCateogryList.totalAmount = totalAmount;
  }
  final String? categoryIcon = jsonConvert.convert<String>(
      json['categoryIcon']);
  if (categoryIcon != null) {
    analyzeAllIncomeCateogryList.categoryIcon = categoryIcon;
  }
  final double? upTotalAmount = jsonConvert.convert<double>(
      json['upTotalAmount']);
  if (upTotalAmount != null) {
    analyzeAllIncomeCateogryList.upTotalAmount = upTotalAmount;
  }
  return analyzeAllIncomeCateogryList;
}

Map<String, dynamic> $AnalyzeAllIncomeCateogryListToJson(
    AnalyzeAllIncomeCateogryList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['totalAmount'] = entity.totalAmount;
  data['categoryIcon'] = entity.categoryIcon;
  data['upTotalAmount'] = entity.upTotalAmount;
  return data;
}

extension AnalyzeAllIncomeCateogryListExtension on AnalyzeAllIncomeCateogryList {
  AnalyzeAllIncomeCateogryList copyWith({
    String? name,
    double? totalAmount,
    String? categoryIcon,
    double? upTotalAmount,
  }) {
    return AnalyzeAllIncomeCateogryList()
      ..name = name ?? this.name
      ..totalAmount = totalAmount ?? this.totalAmount
      ..categoryIcon = categoryIcon ?? this.categoryIcon
      ..upTotalAmount = upTotalAmount ?? this.upTotalAmount;
  }
}

AnalyzeAllExpensesCateogryList $AnalyzeAllExpensesCateogryListFromJson(
    Map<String, dynamic> json) {
  final AnalyzeAllExpensesCateogryList analyzeAllExpensesCateogryList = AnalyzeAllExpensesCateogryList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    analyzeAllExpensesCateogryList.name = name;
  }
  final double? totalAmount = jsonConvert.convert<double>(json['totalAmount']);
  if (totalAmount != null) {
    analyzeAllExpensesCateogryList.totalAmount = totalAmount;
  }
  final String? categoryIcon = jsonConvert.convert<String>(
      json['categoryIcon']);
  if (categoryIcon != null) {
    analyzeAllExpensesCateogryList.categoryIcon = categoryIcon;
  }
  final double? upTotalAmount = jsonConvert.convert<double>(
      json['upTotalAmount']);
  if (upTotalAmount != null) {
    analyzeAllExpensesCateogryList.upTotalAmount = upTotalAmount;
  }
  return analyzeAllExpensesCateogryList;
}

Map<String, dynamic> $AnalyzeAllExpensesCateogryListToJson(
    AnalyzeAllExpensesCateogryList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['totalAmount'] = entity.totalAmount;
  data['categoryIcon'] = entity.categoryIcon;
  data['upTotalAmount'] = entity.upTotalAmount;
  return data;
}

extension AnalyzeAllExpensesCateogryListExtension on AnalyzeAllExpensesCateogryList {
  AnalyzeAllExpensesCateogryList copyWith({
    String? name,
    double? totalAmount,
    String? categoryIcon,
    double? upTotalAmount,
  }) {
    return AnalyzeAllExpensesCateogryList()
      ..name = name ?? this.name
      ..totalAmount = totalAmount ?? this.totalAmount
      ..categoryIcon = categoryIcon ?? this.categoryIcon
      ..upTotalAmount = upTotalAmount ?? this.upTotalAmount;
  }
}

AnalyzeRankList $AnalyzeRankListFromJson(Map<String, dynamic> json) {
  final AnalyzeRankList analyzeRankList = AnalyzeRankList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    analyzeRankList.name = name;
  }
  final String? excerpt = jsonConvert.convert<String>(json['excerpt']);
  if (excerpt != null) {
    analyzeRankList.excerpt = excerpt;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    analyzeRankList.amount = amount;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    analyzeRankList.transactionTime = transactionTime;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    analyzeRankList.id = id;
  }
  return analyzeRankList;
}

Map<String, dynamic> $AnalyzeRankListToJson(AnalyzeRankList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['excerpt'] = entity.excerpt;
  data['amount'] = entity.amount;
  data['transactionTime'] = entity.transactionTime;
  data['id'] = entity.id;
  return data;
}

extension AnalyzeRankListExtension on AnalyzeRankList {
  AnalyzeRankList copyWith({
    String? name,
    String? excerpt,
    double? amount,
    String? transactionTime,
    int? id,
  }) {
    return AnalyzeRankList()
      ..name = name ?? this.name
      ..excerpt = excerpt ?? this.excerpt
      ..amount = amount ?? this.amount
      ..transactionTime = transactionTime ?? this.transactionTime
      ..id = id ?? this.id;
  }
}

AnalyzeAllExpensesRankList $AnalyzeAllExpensesRankListFromJson(
    Map<String, dynamic> json) {
  final AnalyzeAllExpensesRankList analyzeAllExpensesRankList = AnalyzeAllExpensesRankList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    analyzeAllExpensesRankList.name = name;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    analyzeAllExpensesRankList.amount = amount;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    analyzeAllExpensesRankList.id = id;
  }
  return analyzeAllExpensesRankList;
}

Map<String, dynamic> $AnalyzeAllExpensesRankListToJson(
    AnalyzeAllExpensesRankList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['amount'] = entity.amount;
  data['id'] = entity.id;
  return data;
}

extension AnalyzeAllExpensesRankListExtension on AnalyzeAllExpensesRankList {
  AnalyzeAllExpensesRankList copyWith({
    String? name,
    double? amount,
    int? id,
  }) {
    return AnalyzeAllExpensesRankList()
      ..name = name ?? this.name
      ..amount = amount ?? this.amount
      ..id = id ?? this.id;
  }
}

AnalyzeAllIncomeRankList $AnalyzeAllIncomeRankListFromJson(
    Map<String, dynamic> json) {
  final AnalyzeAllIncomeRankList analyzeAllIncomeRankList = AnalyzeAllIncomeRankList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    analyzeAllIncomeRankList.name = name;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    analyzeAllIncomeRankList.amount = amount;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    analyzeAllIncomeRankList.id = id;
  }
  return analyzeAllIncomeRankList;
}

Map<String, dynamic> $AnalyzeAllIncomeRankListToJson(
    AnalyzeAllIncomeRankList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['amount'] = entity.amount;
  data['id'] = entity.id;
  return data;
}

extension AnalyzeAllIncomeRankListExtension on AnalyzeAllIncomeRankList {
  AnalyzeAllIncomeRankList copyWith({
    String? name,
    double? amount,
    int? id,
  }) {
    return AnalyzeAllIncomeRankList()
      ..name = name ?? this.name
      ..amount = amount ?? this.amount
      ..id = id ?? this.id;
  }
}