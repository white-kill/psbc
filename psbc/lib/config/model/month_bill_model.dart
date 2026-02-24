import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/month_bill_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/month_bill_model.g.dart';

@JsonSerializable()
class MonthBillModel {
	String month = '';
	String year = '';
	String dateTime = '';
	double income = 0;
	double expenses = 0;
	double upIncome = 0;
	double upExpenses = 0;

	MonthBillModel();

	factory MonthBillModel.fromJson(Map<String, dynamic> json) => $MonthBillModelFromJson(json);

	Map<String, dynamic> toJson() => $MonthBillModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}