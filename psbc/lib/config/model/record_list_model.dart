import 'package:psbc/config/model/bill_model.dart';
import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/record_list_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/record_list_model.g.dart';

@JsonSerializable()
class RecordListModel {
	List<RecordListList> list = [];
	int total = 0;
	int pages = 0;
	String incomeTotal = '';
	String expensesTotal = '';
	dynamic customizeParam;

	RecordListModel();

	factory RecordListModel.fromJson(Map<String, dynamic> json) => $RecordListModelFromJson(json);

	Map<String, dynamic> toJson() => $RecordListModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class RecordListList {
	String id = '';
	double amount = 0;
	String day = '';
	String transactionTime = '';
	String oppositeName = '';
	String oppositeAccount = '';
	String icon = '';
	String status = '';
	BillListBillDetail? detail;

	RecordListList();

	factory RecordListList.fromJson(Map<String, dynamic> json) => $RecordListListFromJson(json);

	Map<String, dynamic> toJson() => $RecordListListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}