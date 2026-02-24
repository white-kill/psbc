import 'package:psbc/config/model/bill_model.dart';
import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/bill_serach_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/bill_serach_model.g.dart';

@JsonSerializable()
class BillSerachModel {
	List<BillSerachList> list = [];
	late int total = 0;
	dynamic pages;
	double incomeTotal = 0;
	double expensesTotal = 0;
	dynamic customizeParam;

	BillSerachModel();

	factory BillSerachModel.fromJson(Map<String, dynamic> json) => $BillSerachModelFromJson(json);

	Map<String, dynamic> toJson() => $BillSerachModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BillSerachList {
	int id = 0;
	String excerpt = '';
	double amount = 0;
	String accountBalance = '';
	int type = 0;
	String icon = '';
	String transactionTime = '';
	String bankCard = '';
	BillListBillDetail? billDetail;

	BillSerachList();

	factory BillSerachList.fromJson(Map<String, dynamic> json) => $BillSerachListFromJson(json);

	Map<String, dynamic> toJson() => $BillSerachListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BillSerachListBillDetail {
	late int id = 0;
	late String bankName = '';
	late String categoryIcon = '';
	late String icon = '';
	late String oppositeBankId = '';
	late String bankCard = '';
	late String account = '';
	late String excerpt = '';
	late int amount = 0;
	late double accountBalance;
	late String transactionTime = '';
	late String oppositeAccount = '';
	late String accountsTime = '';
	late String merchantBranch = '';
	late String oppositeName = '';
	late String oppositeBankName = '';
	late int type = 0;
	late String transactionChannel = '';
	late String transactionCategory = '';

	BillSerachListBillDetail();

	factory BillSerachListBillDetail.fromJson(Map<String, dynamic> json) => $BillSerachListBillDetailFromJson(json);

	Map<String, dynamic> toJson() => $BillSerachListBillDetailToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}