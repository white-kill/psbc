import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/record_list_model.dart';
import 'package:psbc/config/model/bill_model.dart';


RecordListModel $RecordListModelFromJson(Map<String, dynamic> json) {
  final RecordListModel recordListModel = RecordListModel();
  final List<RecordListList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<RecordListList>(e) as RecordListList)
      .toList();
  if (list != null) {
    recordListModel.list = list;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    recordListModel.total = total;
  }
  final int? pages = jsonConvert.convert<int>(json['pages']);
  if (pages != null) {
    recordListModel.pages = pages;
  }
  final String? incomeTotal = jsonConvert.convert<String>(json['incomeTotal']);
  if (incomeTotal != null) {
    recordListModel.incomeTotal = incomeTotal;
  }
  final String? expensesTotal = jsonConvert.convert<String>(
      json['expensesTotal']);
  if (expensesTotal != null) {
    recordListModel.expensesTotal = expensesTotal;
  }
  final dynamic customizeParam = json['customizeParam'];
  if (customizeParam != null) {
    recordListModel.customizeParam = customizeParam;
  }
  return recordListModel;
}

Map<String, dynamic> $RecordListModelToJson(RecordListModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['total'] = entity.total;
  data['pages'] = entity.pages;
  data['incomeTotal'] = entity.incomeTotal;
  data['expensesTotal'] = entity.expensesTotal;
  data['customizeParam'] = entity.customizeParam;
  return data;
}

extension RecordListModelExtension on RecordListModel {
  RecordListModel copyWith({
    List<RecordListList>? list,
    int? total,
    int? pages,
    String? incomeTotal,
    String? expensesTotal,
    dynamic customizeParam,
  }) {
    return RecordListModel()
      ..list = list ?? this.list
      ..total = total ?? this.total
      ..pages = pages ?? this.pages
      ..incomeTotal = incomeTotal ?? this.incomeTotal
      ..expensesTotal = expensesTotal ?? this.expensesTotal
      ..customizeParam = customizeParam ?? this.customizeParam;
  }
}

RecordListList $RecordListListFromJson(Map<String, dynamic> json) {
  final RecordListList recordListList = RecordListList();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    recordListList.id = id;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    recordListList.amount = amount;
  }
  final String? day = jsonConvert.convert<String>(json['day']);
  if (day != null) {
    recordListList.day = day;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    recordListList.transactionTime = transactionTime;
  }
  final String? oppositeName = jsonConvert.convert<String>(
      json['oppositeName']);
  if (oppositeName != null) {
    recordListList.oppositeName = oppositeName;
  }
  final String? oppositeAccount = jsonConvert.convert<String>(
      json['oppositeAccount']);
  if (oppositeAccount != null) {
    recordListList.oppositeAccount = oppositeAccount;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    recordListList.icon = icon;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    recordListList.status = status;
  }
  final BillListBillDetail? detail = jsonConvert.convert<BillListBillDetail>(
      json['detail']);
  if (detail != null) {
    recordListList.detail = detail;
  }
  return recordListList;
}

Map<String, dynamic> $RecordListListToJson(RecordListList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['amount'] = entity.amount;
  data['day'] = entity.day;
  data['transactionTime'] = entity.transactionTime;
  data['oppositeName'] = entity.oppositeName;
  data['oppositeAccount'] = entity.oppositeAccount;
  data['icon'] = entity.icon;
  data['status'] = entity.status;
  data['detail'] = entity.detail?.toJson();
  return data;
}

extension RecordListListExtension on RecordListList {
  RecordListList copyWith({
    String? id,
    double? amount,
    String? day,
    String? transactionTime,
    String? oppositeName,
    String? oppositeAccount,
    String? icon,
    String? status,
    BillListBillDetail? detail,
  }) {
    return RecordListList()
      ..id = id ?? this.id
      ..amount = amount ?? this.amount
      ..day = day ?? this.day
      ..transactionTime = transactionTime ?? this.transactionTime
      ..oppositeName = oppositeName ?? this.oppositeName
      ..oppositeAccount = oppositeAccount ?? this.oppositeAccount
      ..icon = icon ?? this.icon
      ..status = status ?? this.status
      ..detail = detail ?? this.detail;
  }
}