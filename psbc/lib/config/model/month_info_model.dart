import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/month_info_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/month_info_model.g.dart';

@JsonSerializable()
class MonthInfoModel {
	late double totalAmount = 0;
	late double upTotalAmount = 0;
	late double flexibleAmount = 0;
	late double investmentAmount = 0;
	late MonthInfoIncomeExpenseAnalysis incomeExpenseAnalysis;

	MonthInfoModel();

	factory MonthInfoModel.fromJson(Map<String, dynamic> json) => $MonthInfoModelFromJson(json);

	Map<String, dynamic> toJson() => $MonthInfoModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MonthInfoIncomeExpenseAnalysis {
	late List<MonthInfoIncomeExpenseAnalysisTrend> trend = [];
	late double income = 0;
	late double expenses = 0;
	late double cashSurplus = 0;
	late List<MonthInfoIncomeExpenseAnalysisIncomeList> incomeList = [];
	late List<MonthInfoIncomeExpenseAnalysisExpensesList> expensesList = [];

	MonthInfoIncomeExpenseAnalysis();

	factory MonthInfoIncomeExpenseAnalysis.fromJson(Map<String, dynamic> json) => $MonthInfoIncomeExpenseAnalysisFromJson(json);

	Map<String, dynamic> toJson() => $MonthInfoIncomeExpenseAnalysisToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MonthInfoIncomeExpenseAnalysisTrend {
	late double income = 0;
	late double expenses = 0;
	late String dateTime = '';

	MonthInfoIncomeExpenseAnalysisTrend();

	factory MonthInfoIncomeExpenseAnalysisTrend.fromJson(Map<String, dynamic> json) => $MonthInfoIncomeExpenseAnalysisTrendFromJson(json);

	Map<String, dynamic> toJson() => $MonthInfoIncomeExpenseAnalysisTrendToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MonthInfoIncomeExpenseAnalysisIncomeList {
	late String name = '';
	late double amount = 0;
	late int id = 0;

	MonthInfoIncomeExpenseAnalysisIncomeList();

	factory MonthInfoIncomeExpenseAnalysisIncomeList.fromJson(Map<String, dynamic> json) => $MonthInfoIncomeExpenseAnalysisIncomeListFromJson(json);

	Map<String, dynamic> toJson() => $MonthInfoIncomeExpenseAnalysisIncomeListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MonthInfoIncomeExpenseAnalysisExpensesList {
	late String name = '';
	late double amount = 0;
	late int id = 0;

	MonthInfoIncomeExpenseAnalysisExpensesList();

	factory MonthInfoIncomeExpenseAnalysisExpensesList.fromJson(Map<String, dynamic> json) => $MonthInfoIncomeExpenseAnalysisExpensesListFromJson(json);

	Map<String, dynamic> toJson() => $MonthInfoIncomeExpenseAnalysisExpensesListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}