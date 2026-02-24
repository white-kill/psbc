import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/receipt_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/receipt_model.g.dart';

@JsonSerializable()
class ReceiptModel {
	List<ReceiptList> list = [];
	int total = 0;
	int pages = 0;
	String incomeTotal = '';
	String expensesTotal = '';
	dynamic customizeParam;

	ReceiptModel();

	factory ReceiptModel.fromJson(Map<String, dynamic> json) => $ReceiptModelFromJson(json);

	Map<String, dynamic> toJson() => $ReceiptModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ReceiptList {
	int id = 0;
	double amount = 0;
	String excerpt = '';
	String oppositeAccount = '';
	String transactionTime = '';
	late ReceiptListDetail detail;

	ReceiptList();

	factory ReceiptList.fromJson(Map<String, dynamic> json) => $ReceiptListFromJson(json);

	Map<String, dynamic> toJson() => $ReceiptListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ReceiptListDetail {
	int id = 0;
	double amount = 0;
	String capitalLettersAmount = '';
	String excerpt = '';
	String oppositeBankId = '';
	String transactionTime = '';
	String printTime = '';
	String bankCard = '';
	String bankName = '';
	int type = 0;
	String oppositeBankName = '';
	String oppositeName = '';
	String oppositeAccount = '';
	String icon = '';
	String transactionType = '';
	String transactionChannel = '';
	String certificateNo = '';
	String merchantBranch = '';
	String postscriptno = '';
	String free = '';
	String transactionLogno = '';

	ReceiptListDetail();

	factory ReceiptListDetail.fromJson(Map<String, dynamic> json) => $ReceiptListDetailFromJson(json);

	Map<String, dynamic> toJson() => $ReceiptListDetailToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}