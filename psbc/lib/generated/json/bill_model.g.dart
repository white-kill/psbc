import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/bill_model.dart';

BillModel $BillModelFromJson(Map<String, dynamic> json) {
  final BillModel billModel = BillModel();
  final List<BillList>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<BillList>(e) as BillList).toList();
  if (list != null) {
    billModel.list = list;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    billModel.total = total;
  }
  final dynamic pages = json['pages'];
  if (pages != null) {
    billModel.pages = pages;
  }
  final double? incomeTotal = jsonConvert.convert<double>(json['incomeTotal']);
  if (incomeTotal != null) {
    billModel.incomeTotal = incomeTotal;
  }
  final double? expensesTotal = jsonConvert.convert<double>(
      json['expensesTotal']);
  if (expensesTotal != null) {
    billModel.expensesTotal = expensesTotal;
  }
  final dynamic customizeParam = json['customizeParam'];
  if (customizeParam != null) {
    billModel.customizeParam = customizeParam;
  }
  return billModel;
}

Map<String, dynamic> $BillModelToJson(BillModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['total'] = entity.total;
  data['pages'] = entity.pages;
  data['incomeTotal'] = entity.incomeTotal;
  data['expensesTotal'] = entity.expensesTotal;
  data['customizeParam'] = entity.customizeParam;
  return data;
}

extension BillModelExtension on BillModel {
  BillModel copyWith({
    List<BillList>? list,
    int? total,
    dynamic pages,
    double? incomeTotal,
    double? expensesTotal,
    dynamic customizeParam,
  }) {
    return BillModel()
      ..list = list ?? this.list
      ..total = total ?? this.total
      ..pages = pages ?? this.pages
      ..incomeTotal = incomeTotal ?? this.incomeTotal
      ..expensesTotal = expensesTotal ?? this.expensesTotal
      ..customizeParam = customizeParam ?? this.customizeParam;
  }
}

BillList $BillListFromJson(Map<String, dynamic> json) {
  final BillList billList = BillList();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    billList.id = id;
  }
  final String? excerpt = jsonConvert.convert<String>(json['excerpt']);
  if (excerpt != null) {
    billList.excerpt = excerpt;
  }
  final String? amount = jsonConvert.convert<String>(json['amount']);
  if (amount != null) {
    billList.amount = amount;
  }
  final String? accountBalance = jsonConvert.convert<String>(
      json['accountBalance']);
  if (accountBalance != null) {
    billList.accountBalance = accountBalance;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    billList.type = type;
  }
  final String? day = jsonConvert.convert<String>(json['day']);
  if (day != null) {
    billList.day = day;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    billList.icon = icon;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    billList.transactionTime = transactionTime;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    billList.time = time;
  }
  final String? bankCard = jsonConvert.convert<String>(json['bankCard']);
  if (bankCard != null) {
    billList.bankCard = bankCard;
  }
  final String? endPageTime = jsonConvert.convert<String>(json['endPageTime']);
  if (endPageTime != null) {
    billList.endPageTime = endPageTime;
  }
  final String? month = jsonConvert.convert<String>(json['month']);
  if (month != null) {
    billList.month = month;
  }
  final String? categoryList = jsonConvert.convert<String>(
      json['categoryList']);
  if (categoryList != null) {
    billList.categoryList = categoryList;
  }
  final double? consumeAmount = jsonConvert.convert<double>(
      json['consumeAmount']);
  if (consumeAmount != null) {
    billList.consumeAmount = consumeAmount;
  }
  final String? oppositeBankName = jsonConvert.convert<String>(
      json['oppositeBankName']);
  if (oppositeBankName != null) {
    billList.oppositeBankName = oppositeBankName;
  }
  final double? incomeTotal = jsonConvert.convert<double>(json['incomeTotal']);
  if (incomeTotal != null) {
    billList.incomeTotal = incomeTotal;
  }
  final double? expensesTotal = jsonConvert.convert<double>(
      json['expensesTotal']);
  if (expensesTotal != null) {
    billList.expensesTotal = expensesTotal;
  }
  final String? year = jsonConvert.convert<String>(json['year']);
  if (year != null) {
    billList.year = year;
  }
  final String? merchantBranch = jsonConvert.convert<String>(
      json['merchantBranch']);
  if (merchantBranch != null) {
    billList.merchantBranch = merchantBranch;
  }
  final BillListBillDetail? billDetail = jsonConvert.convert<
      BillListBillDetail>(json['billDetail']);
  if (billDetail != null) {
    billList.billDetail = billDetail;
  }
  return billList;
}

Map<String, dynamic> $BillListToJson(BillList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['excerpt'] = entity.excerpt;
  data['amount'] = entity.amount;
  data['accountBalance'] = entity.accountBalance;
  data['type'] = entity.type;
  data['day'] = entity.day;
  data['icon'] = entity.icon;
  data['transactionTime'] = entity.transactionTime;
  data['time'] = entity.time;
  data['bankCard'] = entity.bankCard;
  data['endPageTime'] = entity.endPageTime;
  data['month'] = entity.month;
  data['categoryList'] = entity.categoryList;
  data['consumeAmount'] = entity.consumeAmount;
  data['oppositeBankName'] = entity.oppositeBankName;
  data['incomeTotal'] = entity.incomeTotal;
  data['expensesTotal'] = entity.expensesTotal;
  data['year'] = entity.year;
  data['merchantBranch'] = entity.merchantBranch;
  data['billDetail'] = entity.billDetail?.toJson();
  return data;
}

extension BillListExtension on BillList {
  BillList copyWith({
    int? id,
    String? excerpt,
    String? amount,
    String? accountBalance,
    String? type,
    String? day,
    String? icon,
    String? transactionTime,
    String? time,
    String? bankCard,
    String? endPageTime,
    String? month,
    String? categoryList,
    double? consumeAmount,
    String? oppositeBankName,
    double? incomeTotal,
    double? expensesTotal,
    String? year,
    String? merchantBranch,
    BillListBillDetail? billDetail,
  }) {
    return BillList()
      ..id = id ?? this.id
      ..excerpt = excerpt ?? this.excerpt
      ..amount = amount ?? this.amount
      ..accountBalance = accountBalance ?? this.accountBalance
      ..type = type ?? this.type
      ..day = day ?? this.day
      ..icon = icon ?? this.icon
      ..transactionTime = transactionTime ?? this.transactionTime
      ..time = time ?? this.time
      ..bankCard = bankCard ?? this.bankCard
      ..endPageTime = endPageTime ?? this.endPageTime
      ..month = month ?? this.month
      ..categoryList = categoryList ?? this.categoryList
      ..consumeAmount = consumeAmount ?? this.consumeAmount
      ..oppositeBankName = oppositeBankName ?? this.oppositeBankName
      ..incomeTotal = incomeTotal ?? this.incomeTotal
      ..expensesTotal = expensesTotal ?? this.expensesTotal
      ..year = year ?? this.year
      ..merchantBranch = merchantBranch ?? this.merchantBranch
      ..billDetail = billDetail ?? this.billDetail;
  }
}

BillListBillDetail $BillListBillDetailFromJson(Map<String, dynamic> json) {
  final BillListBillDetail billListBillDetail = BillListBillDetail();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    billListBillDetail.id = id;
  }
  final String? bankName = jsonConvert.convert<String>(json['bankName']);
  if (bankName != null) {
    billListBillDetail.bankName = bankName;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    billListBillDetail.icon = icon;
  }
  final String? bankCard = jsonConvert.convert<String>(json['bankCard']);
  if (bankCard != null) {
    billListBillDetail.bankCard = bankCard;
  }
  final String? account = jsonConvert.convert<String>(json['account']);
  if (account != null) {
    billListBillDetail.account = account;
  }
  final String? excerpt = jsonConvert.convert<String>(json['excerpt']);
  if (excerpt != null) {
    billListBillDetail.excerpt = excerpt;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    billListBillDetail.amount = amount;
  }
  final double? accountBalance = jsonConvert.convert<double>(
      json['accountBalance']);
  if (accountBalance != null) {
    billListBillDetail.accountBalance = accountBalance;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    billListBillDetail.transactionTime = transactionTime;
  }
  final String? oppositeAccount = jsonConvert.convert<String>(
      json['oppositeAccount']);
  if (oppositeAccount != null) {
    billListBillDetail.oppositeAccount = oppositeAccount;
  }
  final String? accountsTime = jsonConvert.convert<String>(
      json['accountsTime']);
  if (accountsTime != null) {
    billListBillDetail.accountsTime = accountsTime;
  }
  final String? merchantBranch = jsonConvert.convert<String>(
      json['merchantBranch']);
  if (merchantBranch != null) {
    billListBillDetail.merchantBranch = merchantBranch;
  }
  final String? oppositeName = jsonConvert.convert<String>(
      json['oppositeName']);
  if (oppositeName != null) {
    billListBillDetail.oppositeName = oppositeName;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    billListBillDetail.type = type;
  }
  final String? oppositeBankId = jsonConvert.convert<String>(
      json['oppositeBankId']);
  if (oppositeBankId != null) {
    billListBillDetail.oppositeBankId = oppositeBankId;
  }
  final String? oppositeBankName = jsonConvert.convert<String>(
      json['oppositeBankName']);
  if (oppositeBankName != null) {
    billListBillDetail.oppositeBankName = oppositeBankName;
  }
  final String? transactionType = jsonConvert.convert<String>(
      json['transactionType']);
  if (transactionType != null) {
    billListBillDetail.transactionType = transactionType;
  }
  final String? transactionChannel = jsonConvert.convert<String>(
      json['transactionChannel']);
  if (transactionChannel != null) {
    billListBillDetail.transactionChannel = transactionChannel;
  }
  final String? certificateNo = jsonConvert.convert<String>(
      json['certificateNo']);
  if (certificateNo != null) {
    billListBillDetail.certificateNo = certificateNo;
  }
  final String? postscriptno = jsonConvert.convert<String>(
      json['postscriptno']);
  if (postscriptno != null) {
    billListBillDetail.postscriptno = postscriptno;
  }
  final String? billType = jsonConvert.convert<String>(json['billType']);
  if (billType != null) {
    billListBillDetail.billType = billType;
  }
  final String? transactionCategory = jsonConvert.convert<String>(
      json['transactionCategory']);
  if (transactionCategory != null) {
    billListBillDetail.transactionCategory = transactionCategory;
  }
  return billListBillDetail;
}

Map<String, dynamic> $BillListBillDetailToJson(BillListBillDetail entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['bankName'] = entity.bankName;
  data['icon'] = entity.icon;
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
  data['type'] = entity.type;
  data['oppositeBankId'] = entity.oppositeBankId;
  data['oppositeBankName'] = entity.oppositeBankName;
  data['transactionType'] = entity.transactionType;
  data['transactionChannel'] = entity.transactionChannel;
  data['certificateNo'] = entity.certificateNo;
  data['postscriptno'] = entity.postscriptno;
  data['billType'] = entity.billType;
  data['transactionCategory'] = entity.transactionCategory;
  return data;
}

extension BillListBillDetailExtension on BillListBillDetail {
  BillListBillDetail copyWith({
    String? id,
    String? bankName,
    String? icon,
    String? bankCard,
    String? account,
    String? excerpt,
    double? amount,
    double? accountBalance,
    String? transactionTime,
    String? oppositeAccount,
    String? accountsTime,
    String? merchantBranch,
    String? oppositeName,
    String? type,
    String? oppositeBankId,
    String? oppositeBankName,
    String? transactionType,
    String? transactionChannel,
    String? certificateNo,
    String? postscriptno,
    String? billType,
    String? transactionCategory,
  }) {
    return BillListBillDetail()
      ..id = id ?? this.id
      ..bankName = bankName ?? this.bankName
      ..icon = icon ?? this.icon
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
      ..type = type ?? this.type
      ..oppositeBankId = oppositeBankId ?? this.oppositeBankId
      ..oppositeBankName = oppositeBankName ?? this.oppositeBankName
      ..transactionType = transactionType ?? this.transactionType
      ..transactionChannel = transactionChannel ?? this.transactionChannel
      ..certificateNo = certificateNo ?? this.certificateNo
      ..postscriptno = postscriptno ?? this.postscriptno
      ..billType = billType ?? this.billType
      ..transactionCategory = transactionCategory ?? this.transactionCategory;
  }
}