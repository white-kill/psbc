import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/analyze_all_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/analyze_all_model.g.dart';

@JsonSerializable()
class AnalyzeAllModel {
	double income = 0;
	double expenses = 0;
	double cashSurplus = 0;
	List<AnalyzeAllTrendList> trendList = [];
	List<AnalyzeAllCateogryList> incomeCateogryList = [];
	List<AnalyzeAllCateogryList> expensesCateogryList = [];
	List<AnalyzeRankList> expensesRankList = [];
	List<AnalyzeRankList> incomeRankList = [];

	AnalyzeAllModel();

	factory AnalyzeAllModel.fromJson(Map<String, dynamic> json) => $AnalyzeAllModelFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeAllModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeAllTrendList {
	double income = 0;
	double expenses = 0;
	String dateTime = '';

	AnalyzeAllTrendList();

	factory AnalyzeAllTrendList.fromJson(Map<String, dynamic> json) => $AnalyzeAllTrendListFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeAllTrendListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}


@JsonSerializable()
class AnalyzeAllCateogryList {
	String name = '';
	double totalAmount = 0;
	String categoryIcon = '';
	double upTotalAmount = 0;
	String count = '';
	double rate = 0;

	AnalyzeAllCateogryList();

	factory AnalyzeAllCateogryList.fromJson(Map<String, dynamic> json) => $AnalyzeAllCateogryListFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeAllCateogryListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeAllIncomeCateogryList {
	String name = '';
	double totalAmount = 0;
	String categoryIcon = '';
	double upTotalAmount = 0;

	AnalyzeAllIncomeCateogryList();

	factory AnalyzeAllIncomeCateogryList.fromJson(Map<String, dynamic> json) => $AnalyzeAllIncomeCateogryListFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeAllIncomeCateogryListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeAllExpensesCateogryList {
	String name = '';
	double totalAmount = 0;
	String categoryIcon = '';
	double upTotalAmount = 0;

	AnalyzeAllExpensesCateogryList();

	factory AnalyzeAllExpensesCateogryList.fromJson(Map<String, dynamic> json) => $AnalyzeAllExpensesCateogryListFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeAllExpensesCateogryListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeRankList {
	String name = '';
	String excerpt = '';
	double amount = 0;
	String transactionTime = '';
	int id = 0;

	AnalyzeRankList();

	factory AnalyzeRankList.fromJson(Map<String, dynamic> json) => $AnalyzeRankListFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeRankListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeAllExpensesRankList {
	 String name = '';
	 double amount = 0;
	 int id = 0;

	AnalyzeAllExpensesRankList();

	factory AnalyzeAllExpensesRankList.fromJson(Map<String, dynamic> json) => $AnalyzeAllExpensesRankListFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeAllExpensesRankListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AnalyzeAllIncomeRankList {
	late String name = '';
	late double amount;
	late int id = 0;

	AnalyzeAllIncomeRankList();

	factory AnalyzeAllIncomeRankList.fromJson(Map<String, dynamic> json) => $AnalyzeAllIncomeRankListFromJson(json);

	Map<String, dynamic> toJson() => $AnalyzeAllIncomeRankListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}