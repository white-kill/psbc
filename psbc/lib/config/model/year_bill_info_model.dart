import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/year_bill_info_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/year_bill_info_model.g.dart';

@JsonSerializable()
class YearBillInfoModel {
	String expensesMaxDateTime = '';
	int year = 0;
	String daysDeparture = '';
	double totalExpenses = 0;
	double monthCount = 0;
	String jtcx = '';
	double oldYearEndbalance = 0;
	String incomeMaxDateTime = '';
	double cymsMaxAmount = 0;
	List<YearBillInfoCategoryList> categoryList = [];
	int incomeCount = 0;
	double yearSurplus = 0;
	double yearEndbalance = 0;
	String nightTime = '';
	double expensesLastYear = 0;
	int count = 0;
	double expensesMaxAmount = 0;
	String cymsTime = '';
	String medalNum = '';
	String medalList = '';
	int expensesCount = 0;
	double totalIncome = 0;
	String cyms = '';
	String timePeriod = '';
	int days = 0;
	double incomeLastYear = 0;
	double incomeMaxAmount = 0;

	YearBillInfoModel();

	factory YearBillInfoModel.fromJson(Map<String, dynamic> json) => $YearBillInfoModelFromJson(json);

	Map<String, dynamic> toJson() => $YearBillInfoModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class YearBillInfoCategoryList {
	double amount = 0;
	String category = '';

	YearBillInfoCategoryList();

	factory YearBillInfoCategoryList.fromJson(Map<String, dynamic> json) => $YearBillInfoCategoryListFromJson(json);

	Map<String, dynamic> toJson() => $YearBillInfoCategoryListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}