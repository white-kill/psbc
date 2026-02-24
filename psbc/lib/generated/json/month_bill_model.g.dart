import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/month_bill_model.dart';

MonthBillModel $MonthBillModelFromJson(Map<String, dynamic> json) {
  final MonthBillModel monthBillModel = MonthBillModel();
  final String? month = jsonConvert.convert<String>(json['month']);
  if (month != null) {
    monthBillModel.month = month;
  }
  final String? year = jsonConvert.convert<String>(json['year']);
  if (year != null) {
    monthBillModel.year = year;
  }
  final String? dateTime = jsonConvert.convert<String>(json['dateTime']);
  if (dateTime != null) {
    monthBillModel.dateTime = dateTime;
  }
  final double? income = jsonConvert.convert<double>(json['income']);
  if (income != null) {
    monthBillModel.income = income;
  }
  final double? expenses = jsonConvert.convert<double>(json['expenses']);
  if (expenses != null) {
    monthBillModel.expenses = expenses;
  }
  final double? upIncome = jsonConvert.convert<double>(json['upIncome']);
  if (upIncome != null) {
    monthBillModel.upIncome = upIncome;
  }
  final double? upExpenses = jsonConvert.convert<double>(json['upExpenses']);
  if (upExpenses != null) {
    monthBillModel.upExpenses = upExpenses;
  }
  return monthBillModel;
}

Map<String, dynamic> $MonthBillModelToJson(MonthBillModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['month'] = entity.month;
  data['year'] = entity.year;
  data['dateTime'] = entity.dateTime;
  data['income'] = entity.income;
  data['expenses'] = entity.expenses;
  data['upIncome'] = entity.upIncome;
  data['upExpenses'] = entity.upExpenses;
  return data;
}

extension MonthBillModelExtension on MonthBillModel {
  MonthBillModel copyWith({
    String? month,
    String? year,
    String? dateTime,
    double? income,
    double? expenses,
    double? upIncome,
    double? upExpenses,
  }) {
    return MonthBillModel()
      ..month = month ?? this.month
      ..year = year ?? this.year
      ..dateTime = dateTime ?? this.dateTime
      ..income = income ?? this.income
      ..expenses = expenses ?? this.expenses
      ..upIncome = upIncome ?? this.upIncome
      ..upExpenses = upExpenses ?? this.upExpenses;
  }
}