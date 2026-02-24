import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/bill_serach_model.dart';
import 'package:psbc/config/model/bill_model.dart';


BillSerachModel $BillSerachModelFromJson(Map<String, dynamic> json) {
  final BillSerachModel billSerachModel = BillSerachModel();
  final List<BillSerachList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<BillSerachList>(e) as BillSerachList)
      .toList();
  if (list != null) {
    billSerachModel.list = list;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    billSerachModel.total = total;
  }
  final dynamic pages = json['pages'];
  if (pages != null) {
    billSerachModel.pages = pages;
  }
  final double? incomeTotal = jsonConvert.convert<double>(json['incomeTotal']);
  if (incomeTotal != null) {
    billSerachModel.incomeTotal = incomeTotal;
  }
  final double? expensesTotal = jsonConvert.convert<double>(
      json['expensesTotal']);
  if (expensesTotal != null) {
    billSerachModel.expensesTotal = expensesTotal;
  }
  final dynamic customizeParam = json['customizeParam'];
  if (customizeParam != null) {
    billSerachModel.customizeParam = customizeParam;
  }
  return billSerachModel;
}

Map<String, dynamic> $BillSerachModelToJson(BillSerachModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['total'] = entity.total;
  data['pages'] = entity.pages;
  data['incomeTotal'] = entity.incomeTotal;
  data['expensesTotal'] = entity.expensesTotal;
  data['customizeParam'] = entity.customizeParam;
  return data;
}

extension BillSerachModelExtension on BillSerachModel {
  BillSerachModel copyWith({
    List<BillSerachList>? list,
    int? total,
    dynamic pages,
    double? incomeTotal,
    double? expensesTotal,
    dynamic customizeParam,
  }) {
    return BillSerachModel()
      ..list = list ?? this.list
      ..total = total ?? this.total
      ..pages = pages ?? this.pages
      ..incomeTotal = incomeTotal ?? this.incomeTotal
      ..expensesTotal = expensesTotal ?? this.expensesTotal
      ..customizeParam = customizeParam ?? this.customizeParam;
  }
}

BillSerachList $BillSerachListFromJson(Map<String, dynamic> json) {
  final BillSerachList billSerachList = BillSerachList();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    billSerachList.id = id;
  }
  final String? excerpt = jsonConvert.convert<String>(json['excerpt']);
  if (excerpt != null) {
    billSerachList.excerpt = excerpt;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    billSerachList.amount = amount;
  }
  final String? accountBalance = jsonConvert.convert<String>(
      json['accountBalance']);
  if (accountBalance != null) {
    billSerachList.accountBalance = accountBalance;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    billSerachList.type = type;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    billSerachList.icon = icon;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    billSerachList.transactionTime = transactionTime;
  }
  final String? bankCard = jsonConvert.convert<String>(json['bankCard']);
  if (bankCard != null) {
    billSerachList.bankCard = bankCard;
  }
  final BillListBillDetail? billDetail = jsonConvert.convert<
      BillListBillDetail>(json['billDetail']);
  if (billDetail != null) {
    billSerachList.billDetail = billDetail;
  }
  return billSerachList;
}

Map<String, dynamic> $BillSerachListToJson(BillSerachList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['excerpt'] = entity.excerpt;
  data['amount'] = entity.amount;
  data['accountBalance'] = entity.accountBalance;
  data['type'] = entity.type;
  data['icon'] = entity.icon;
  data['transactionTime'] = entity.transactionTime;
  data['bankCard'] = entity.bankCard;
  data['billDetail'] = entity.billDetail?.toJson();
  return data;
}

extension BillSerachListExtension on BillSerachList {
  BillSerachList copyWith({
    int? id,
    String? excerpt,
    double? amount,
    String? accountBalance,
    int? type,
    String? icon,
    String? transactionTime,
    String? bankCard,
    BillListBillDetail? billDetail,
  }) {
    return BillSerachList()
      ..id = id ?? this.id
      ..excerpt = excerpt ?? this.excerpt
      ..amount = amount ?? this.amount
      ..accountBalance = accountBalance ?? this.accountBalance
      ..type = type ?? this.type
      ..icon = icon ?? this.icon
      ..transactionTime = transactionTime ?? this.transactionTime
      ..bankCard = bankCard ?? this.bankCard
      ..billDetail = billDetail ?? this.billDetail;
  }
}

BillSerachListBillDetail $BillSerachListBillDetailFromJson(
    Map<String, dynamic> json) {
  final BillSerachListBillDetail billSerachListBillDetail = BillSerachListBillDetail();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    billSerachListBillDetail.id = id;
  }
  final String? bankName = jsonConvert.convert<String>(json['bankName']);
  if (bankName != null) {
    billSerachListBillDetail.bankName = bankName;
  }
  final String? categoryIcon = jsonConvert.convert<String>(
      json['categoryIcon']);
  if (categoryIcon != null) {
    billSerachListBillDetail.categoryIcon = categoryIcon;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    billSerachListBillDetail.icon = icon;
  }
  final String? oppositeBankId = jsonConvert.convert<String>(
      json['oppositeBankId']);
  if (oppositeBankId != null) {
    billSerachListBillDetail.oppositeBankId = oppositeBankId;
  }
  final String? bankCard = jsonConvert.convert<String>(json['bankCard']);
  if (bankCard != null) {
    billSerachListBillDetail.bankCard = bankCard;
  }
  final String? account = jsonConvert.convert<String>(json['account']);
  if (account != null) {
    billSerachListBillDetail.account = account;
  }
  final String? excerpt = jsonConvert.convert<String>(json['excerpt']);
  if (excerpt != null) {
    billSerachListBillDetail.excerpt = excerpt;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    billSerachListBillDetail.amount = amount;
  }
  final double? accountBalance = jsonConvert.convert<double>(
      json['accountBalance']);
  if (accountBalance != null) {
    billSerachListBillDetail.accountBalance = accountBalance;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    billSerachListBillDetail.transactionTime = transactionTime;
  }
  final String? oppositeAccount = jsonConvert.convert<String>(
      json['oppositeAccount']);
  if (oppositeAccount != null) {
    billSerachListBillDetail.oppositeAccount = oppositeAccount;
  }
  final String? accountsTime = jsonConvert.convert<String>(
      json['accountsTime']);
  if (accountsTime != null) {
    billSerachListBillDetail.accountsTime = accountsTime;
  }
  final String? merchantBranch = jsonConvert.convert<String>(
      json['merchantBranch']);
  if (merchantBranch != null) {
    billSerachListBillDetail.merchantBranch = merchantBranch;
  }
  final String? oppositeName = jsonConvert.convert<String>(
      json['oppositeName']);
  if (oppositeName != null) {
    billSerachListBillDetail.oppositeName = oppositeName;
  }
  final String? oppositeBankName = jsonConvert.convert<String>(
      json['oppositeBankName']);
  if (oppositeBankName != null) {
    billSerachListBillDetail.oppositeBankName = oppositeBankName;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    billSerachListBillDetail.type = type;
  }
  final String? transactionChannel = jsonConvert.convert<String>(
      json['transactionChannel']);
  if (transactionChannel != null) {
    billSerachListBillDetail.transactionChannel = transactionChannel;
  }
  final String? transactionCategory = jsonConvert.convert<String>(
      json['transactionCategory']);
  if (transactionCategory != null) {
    billSerachListBillDetail.transactionCategory = transactionCategory;
  }
  return billSerachListBillDetail;
}

Map<String, dynamic> $BillSerachListBillDetailToJson(
    BillSerachListBillDetail entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['bankName'] = entity.bankName;
  data['categoryIcon'] = entity.categoryIcon;
  data['icon'] = entity.icon;
  data['oppositeBankId'] = entity.oppositeBankId;
  data['bankCard'] = entity.bankCard;
  data['account'] = entity.account;
  data['excerpt'] = entity.excerpt;
  data['amount'] = entity.amount;
  data['accountBalance'] = entity.accountBalance;
  data['transactionTime'] = entity.transactionTime;
  data['oppositeAccount'] = entity.oppositeAccount;
  data['accountsTime'] = entity.accountsTime;
  data['merchantBranch'] = entity.merchantBranch;
  data['oppositeName'] = entity.oppositeName;
  data['oppositeBankName'] = entity.oppositeBankName;
  data['type'] = entity.type;
  data['transactionChannel'] = entity.transactionChannel;
  data['transactionCategory'] = entity.transactionCategory;
  return data;
}

extension BillSerachListBillDetailExtension on BillSerachListBillDetail {
  BillSerachListBillDetail copyWith({
    int? id,
    String? bankName,
    String? categoryIcon,
    String? icon,
    String? oppositeBankId,
    String? bankCard,
    String? account,
    String? excerpt,
    int? amount,
    double? accountBalance,
    String? transactionTime,
    String? oppositeAccount,
    String? accountsTime,
    String? merchantBranch,
    String? oppositeName,
    String? oppositeBankName,
    int? type,
    String? transactionChannel,
    String? transactionCategory,
  }) {
    return BillSerachListBillDetail()
      ..id = id ?? this.id
      ..bankName = bankName ?? this.bankName
      ..categoryIcon = categoryIcon ?? this.categoryIcon
      ..icon = icon ?? this.icon
      ..oppositeBankId = oppositeBankId ?? this.oppositeBankId
      ..bankCard = bankCard ?? this.bankCard
      ..account = account ?? this.account
      ..excerpt = excerpt ?? this.excerpt
      ..amount = amount ?? this.amount
      ..accountBalance = accountBalance ?? this.accountBalance
      ..transactionTime = transactionTime ?? this.transactionTime
      ..oppositeAccount = oppositeAccount ?? this.oppositeAccount
      ..accountsTime = accountsTime ?? this.accountsTime
      ..merchantBranch = merchantBranch ?? this.merchantBranch
      ..oppositeName = oppositeName ?? this.oppositeName
      ..oppositeBankName = oppositeBankName ?? this.oppositeBankName
      ..type = type ?? this.type
      ..transactionChannel = transactionChannel ?? this.transactionChannel
      ..transactionCategory = transactionCategory ?? this.transactionCategory;
  }
}