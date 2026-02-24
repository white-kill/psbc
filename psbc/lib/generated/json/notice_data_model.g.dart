import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/notice_data_model.dart';

NoticeDataModel $NoticeDataModelFromJson(Map<String, dynamic> json) {
  final NoticeDataModel noticeDataModel = NoticeDataModel();
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    noticeDataModel.amount = amount;
  }
  final String? postscript = jsonConvert.convert<String>(json['postscript']);
  if (postscript != null) {
    noticeDataModel.postscript = postscript;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    noticeDataModel.transactionTime = transactionTime;
  }
  final String? oppositeName = jsonConvert.convert<String>(
      json['oppositeName']);
  if (oppositeName != null) {
    noticeDataModel.oppositeName = oppositeName;
  }
  final String? oppositeAccount = jsonConvert.convert<String>(
      json['oppositeAccount']);
  if (oppositeAccount != null) {
    noticeDataModel.oppositeAccount = oppositeAccount;
  }
  final String? oppositeBank = jsonConvert.convert<String>(
      json['oppositeBank']);
  if (oppositeBank != null) {
    noticeDataModel.oppositeBank = oppositeBank;
  }
  final String? bank = jsonConvert.convert<String>(json['bank']);
  if (bank != null) {
    noticeDataModel.bank = bank;
  }
  final String? account = jsonConvert.convert<String>(json['account']);
  if (account != null) {
    noticeDataModel.account = account;
  }
  return noticeDataModel;
}

Map<String, dynamic> $NoticeDataModelToJson(NoticeDataModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['amount'] = entity.amount;
  data['postscript'] = entity.postscript;
  data['transactionTime'] = entity.transactionTime;
  data['oppositeName'] = entity.oppositeName;
  data['oppositeAccount'] = entity.oppositeAccount;
  data['oppositeBank'] = entity.oppositeBank;
  data['bank'] = entity.bank;
  data['account'] = entity.account;
  return data;
}

extension NoticeDataModelExtension on NoticeDataModel {
  NoticeDataModel copyWith({
    double? amount,
    String? postscript,
    String? transactionTime,
    String? oppositeName,
    String? oppositeAccount,
    String? oppositeBank,
    String? bank,
    String? account,
  }) {
    return NoticeDataModel()
      ..amount = amount ?? this.amount
      ..postscript = postscript ?? this.postscript
      ..transactionTime = transactionTime ?? this.transactionTime
      ..oppositeName = oppositeName ?? this.oppositeName
      ..oppositeAccount = oppositeAccount ?? this.oppositeAccount
      ..oppositeBank = oppositeBank ?? this.oppositeBank
      ..bank = bank ?? this.bank
      ..account = account ?? this.account;
  }
}