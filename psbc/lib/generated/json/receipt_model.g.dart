import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/receipt_model.dart';

ReceiptModel $ReceiptModelFromJson(Map<String, dynamic> json) {
  final ReceiptModel receiptModel = ReceiptModel();
  final List<ReceiptList>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ReceiptList>(e) as ReceiptList).toList();
  if (list != null) {
    receiptModel.list = list;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    receiptModel.total = total;
  }
  final int? pages = jsonConvert.convert<int>(json['pages']);
  if (pages != null) {
    receiptModel.pages = pages;
  }
  final String? incomeTotal = jsonConvert.convert<String>(json['incomeTotal']);
  if (incomeTotal != null) {
    receiptModel.incomeTotal = incomeTotal;
  }
  final String? expensesTotal = jsonConvert.convert<String>(
      json['expensesTotal']);
  if (expensesTotal != null) {
    receiptModel.expensesTotal = expensesTotal;
  }
  final dynamic customizeParam = json['customizeParam'];
  if (customizeParam != null) {
    receiptModel.customizeParam = customizeParam;
  }
  return receiptModel;
}

Map<String, dynamic> $ReceiptModelToJson(ReceiptModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['total'] = entity.total;
  data['pages'] = entity.pages;
  data['incomeTotal'] = entity.incomeTotal;
  data['expensesTotal'] = entity.expensesTotal;
  data['customizeParam'] = entity.customizeParam;
  return data;
}

extension ReceiptModelExtension on ReceiptModel {
  ReceiptModel copyWith({
    List<ReceiptList>? list,
    int? total,
    int? pages,
    String? incomeTotal,
    String? expensesTotal,
    dynamic customizeParam,
  }) {
    return ReceiptModel()
      ..list = list ?? this.list
      ..total = total ?? this.total
      ..pages = pages ?? this.pages
      ..incomeTotal = incomeTotal ?? this.incomeTotal
      ..expensesTotal = expensesTotal ?? this.expensesTotal
      ..customizeParam = customizeParam ?? this.customizeParam;
  }
}

ReceiptList $ReceiptListFromJson(Map<String, dynamic> json) {
  final ReceiptList receiptList = ReceiptList();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    receiptList.id = id;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    receiptList.amount = amount;
  }
  final String? excerpt = jsonConvert.convert<String>(json['excerpt']);
  if (excerpt != null) {
    receiptList.excerpt = excerpt;
  }
  final String? oppositeAccount = jsonConvert.convert<String>(
      json['oppositeAccount']);
  if (oppositeAccount != null) {
    receiptList.oppositeAccount = oppositeAccount;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    receiptList.transactionTime = transactionTime;
  }
  final ReceiptListDetail? detail = jsonConvert.convert<ReceiptListDetail>(
      json['detail']);
  if (detail != null) {
    receiptList.detail = detail;
  }
  return receiptList;
}

Map<String, dynamic> $ReceiptListToJson(ReceiptList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['amount'] = entity.amount;
  data['excerpt'] = entity.excerpt;
  data['oppositeAccount'] = entity.oppositeAccount;
  data['transactionTime'] = entity.transactionTime;
  data['detail'] = entity.detail.toJson();
  return data;
}

extension ReceiptListExtension on ReceiptList {
  ReceiptList copyWith({
    int? id,
    double? amount,
    String? excerpt,
    String? oppositeAccount,
    String? transactionTime,
    ReceiptListDetail? detail,
  }) {
    return ReceiptList()
      ..id = id ?? this.id
      ..amount = amount ?? this.amount
      ..excerpt = excerpt ?? this.excerpt
      ..oppositeAccount = oppositeAccount ?? this.oppositeAccount
      ..transactionTime = transactionTime ?? this.transactionTime
      ..detail = detail ?? this.detail;
  }
}

ReceiptListDetail $ReceiptListDetailFromJson(Map<String, dynamic> json) {
  final ReceiptListDetail receiptListDetail = ReceiptListDetail();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    receiptListDetail.id = id;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    receiptListDetail.amount = amount;
  }
  final String? capitalLettersAmount = jsonConvert.convert<String>(
      json['capitalLettersAmount']);
  if (capitalLettersAmount != null) {
    receiptListDetail.capitalLettersAmount = capitalLettersAmount;
  }
  final String? excerpt = jsonConvert.convert<String>(json['excerpt']);
  if (excerpt != null) {
    receiptListDetail.excerpt = excerpt;
  }
  final String? oppositeBankId = jsonConvert.convert<String>(
      json['oppositeBankId']);
  if (oppositeBankId != null) {
    receiptListDetail.oppositeBankId = oppositeBankId;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    receiptListDetail.transactionTime = transactionTime;
  }
  final String? printTime = jsonConvert.convert<String>(json['printTime']);
  if (printTime != null) {
    receiptListDetail.printTime = printTime;
  }
  final String? bankCard = jsonConvert.convert<String>(json['bankCard']);
  if (bankCard != null) {
    receiptListDetail.bankCard = bankCard;
  }
  final String? bankName = jsonConvert.convert<String>(json['bankName']);
  if (bankName != null) {
    receiptListDetail.bankName = bankName;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    receiptListDetail.type = type;
  }
  final String? oppositeBankName = jsonConvert.convert<String>(
      json['oppositeBankName']);
  if (oppositeBankName != null) {
    receiptListDetail.oppositeBankName = oppositeBankName;
  }
  final String? oppositeName = jsonConvert.convert<String>(
      json['oppositeName']);
  if (oppositeName != null) {
    receiptListDetail.oppositeName = oppositeName;
  }
  final String? oppositeAccount = jsonConvert.convert<String>(
      json['oppositeAccount']);
  if (oppositeAccount != null) {
    receiptListDetail.oppositeAccount = oppositeAccount;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    receiptListDetail.icon = icon;
  }
  final String? transactionType = jsonConvert.convert<String>(
      json['transactionType']);
  if (transactionType != null) {
    receiptListDetail.transactionType = transactionType;
  }
  final String? transactionChannel = jsonConvert.convert<String>(
      json['transactionChannel']);
  if (transactionChannel != null) {
    receiptListDetail.transactionChannel = transactionChannel;
  }
  final String? certificateNo = jsonConvert.convert<String>(
      json['certificateNo']);
  if (certificateNo != null) {
    receiptListDetail.certificateNo = certificateNo;
  }
  final String? merchantBranch = jsonConvert.convert<String>(
      json['merchantBranch']);
  if (merchantBranch != null) {
    receiptListDetail.merchantBranch = merchantBranch;
  }
  final String? postscriptno = jsonConvert.convert<String>(
      json['postscriptno']);
  if (postscriptno != null) {
    receiptListDetail.postscriptno = postscriptno;
  }
  final String? free = jsonConvert.convert<String>(json['free']);
  if (free != null) {
    receiptListDetail.free = free;
  }
  final String? transactionLogno = jsonConvert.convert<String>(
      json['transactionLogno']);
  if (transactionLogno != null) {
    receiptListDetail.transactionLogno = transactionLogno;
  }
  return receiptListDetail;
}

Map<String, dynamic> $ReceiptListDetailToJson(ReceiptListDetail entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['amount'] = entity.amount;
  data['capitalLettersAmount'] = entity.capitalLettersAmount;
  data['excerpt'] = entity.excerpt;
  data['oppositeBankId'] = entity.oppositeBankId;
  data['transactionTime'] = entity.transactionTime;
  data['printTime'] = entity.printTime;
  data['bankCard'] = entity.bankCard;
  data['bankName'] = entity.bankName;
  data['type'] = entity.type;
  data['oppositeBankName'] = entity.oppositeBankName;
  data['oppositeName'] = entity.oppositeName;
  data['oppositeAccount'] = entity.oppositeAccount;
  data['icon'] = entity.icon;
  data['transactionType'] = entity.transactionType;
  data['transactionChannel'] = entity.transactionChannel;
  data['certificateNo'] = entity.certificateNo;
  data['merchantBranch'] = entity.merchantBranch;
  data['postscriptno'] = entity.postscriptno;
  data['free'] = entity.free;
  data['transactionLogno'] = entity.transactionLogno;
  return data;
}

extension ReceiptListDetailExtension on ReceiptListDetail {
  ReceiptListDetail copyWith({
    int? id,
    double? amount,
    String? capitalLettersAmount,
    String? excerpt,
    String? oppositeBankId,
    String? transactionTime,
    String? printTime,
    String? bankCard,
    String? bankName,
    int? type,
    String? oppositeBankName,
    String? oppositeName,
    String? oppositeAccount,
    String? icon,
    String? transactionType,
    String? transactionChannel,
    String? certificateNo,
    String? merchantBranch,
    String? postscriptno,
    String? free,
    String? transactionLogno,
  }) {
    return ReceiptListDetail()
      ..id = id ?? this.id
      ..amount = amount ?? this.amount
      ..capitalLettersAmount = capitalLettersAmount ?? this.capitalLettersAmount
      ..excerpt = excerpt ?? this.excerpt
      ..oppositeBankId = oppositeBankId ?? this.oppositeBankId
      ..transactionTime = transactionTime ?? this.transactionTime
      ..printTime = printTime ?? this.printTime
      ..bankCard = bankCard ?? this.bankCard
      ..bankName = bankName ?? this.bankName
      ..type = type ?? this.type
      ..oppositeBankName = oppositeBankName ?? this.oppositeBankName
      ..oppositeName = oppositeName ?? this.oppositeName
      ..oppositeAccount = oppositeAccount ?? this.oppositeAccount
      ..icon = icon ?? this.icon
      ..transactionType = transactionType ?? this.transactionType
      ..transactionChannel = transactionChannel ?? this.transactionChannel
      ..certificateNo = certificateNo ?? this.certificateNo
      ..merchantBranch = merchantBranch ?? this.merchantBranch
      ..postscriptno = postscriptno ?? this.postscriptno
      ..free = free ?? this.free
      ..transactionLogno = transactionLogno ?? this.transactionLogno;
  }
}