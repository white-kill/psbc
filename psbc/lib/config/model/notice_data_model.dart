import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/notice_data_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/notice_data_model.g.dart';

@JsonSerializable()
class NoticeDataModel {
	double amount = 0;
	String postscript = '';
	String transactionTime = '';
	String oppositeName = '';
	String oppositeAccount = '';
	String oppositeBank = '';
	String bank = '';
	String account = '';

	NoticeDataModel();

	factory NoticeDataModel.fromJson(Map<String, dynamic> json) => $NoticeDataModelFromJson(json);

	Map<String, dynamic> toJson() => $NoticeDataModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}