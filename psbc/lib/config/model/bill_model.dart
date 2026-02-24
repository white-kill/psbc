import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/bill_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/bill_model.g.dart';

@JsonSerializable()
class BillModel {
  List<BillList> list = [];
  int total = 0;
  dynamic pages;
  double incomeTotal = 0;
  double expensesTotal = 0;
  dynamic customizeParam;

  BillModel();

  factory BillModel.fromJson(Map<String, dynamic> json) =>
      $BillModelFromJson(json);

  Map<String, dynamic> toJson() => $BillModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BillList {
  int id = 0;
  String excerpt = '';
  String amount = '';
  String accountBalance = '';
  String type = '';
  String day = '';
  String icon = '';
  String transactionTime = '';
  String time = '';
  String bankCard = '';
  String endPageTime = '';
  String month = '';
  String categoryList = '';
  double consumeAmount = 0;
  String oppositeBankName = '';
  double incomeTotal = 0;
  double expensesTotal = 0;
  String year = '';
  String merchantBranch = '';
  BillListBillDetail? billDetail;

  BillList();

  factory BillList.fromJson(Map<String, dynamic> json) =>
      $BillListFromJson(json);

  Map<String, dynamic> toJson() => $BillListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BillListBillDetail {
  String id = '';
  String bankName = '';
  String icon = '';
  String bankCard = '';
  String account = '';
  String excerpt = '';
  double amount = 0;
  double accountBalance = 0;
  String transactionTime = '';
  String oppositeAccount = '';
  String accountsTime = '';
  String merchantBranch = '';
  String oppositeName = '';
  String type = '';
  String oppositeBankId = '';
  String oppositeBankName = '';
  String transactionType = '';
  String transactionChannel = '';
  String certificateNo = '';
  String postscriptno = '';
  String billType = '';
  String transactionCategory = '';

  BillListBillDetail();

  factory BillListBillDetail.fromJson(Map<String, dynamic> json) =>
      $BillListBillDetailFromJson(json);

  Map<String, dynamic> toJson() => $BillListBillDetailToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
