import 'package:psbc/generated/json/base/json_convert_content.dart';
import 'package:psbc/config/model/rank_model.dart';

RankModel $RankModelFromJson(Map<String, dynamic> json) {
  final RankModel rankModel = RankModel();
  final List<RankList>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<RankList>(e) as RankList).toList();
  if (list != null) {
    rankModel.list = list;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    rankModel.total = total;
  }
  final dynamic pages = json['pages'];
  if (pages != null) {
    rankModel.pages = pages;
  }
  final String? incomeTotal = jsonConvert.convert<String>(json['incomeTotal']);
  if (incomeTotal != null) {
    rankModel.incomeTotal = incomeTotal;
  }
  final String? expensesTotal = jsonConvert.convert<String>(
      json['expensesTotal']);
  if (expensesTotal != null) {
    rankModel.expensesTotal = expensesTotal;
  }
  final dynamic customizeParam = json['customizeParam'];
  if (customizeParam != null) {
    rankModel.customizeParam = customizeParam;
  }
  return rankModel;
}

Map<String, dynamic> $RankModelToJson(RankModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['total'] = entity.total;
  data['pages'] = entity.pages;
  data['incomeTotal'] = entity.incomeTotal;
  data['expensesTotal'] = entity.expensesTotal;
  data['customizeParam'] = entity.customizeParam;
  return data;
}

extension RankModelExtension on RankModel {
  RankModel copyWith({
    List<RankList>? list,
    int? total,
    dynamic pages,
    String? incomeTotal,
    String? expensesTotal,
    dynamic customizeParam,
  }) {
    return RankModel()
      ..list = list ?? this.list
      ..total = total ?? this.total
      ..pages = pages ?? this.pages
      ..incomeTotal = incomeTotal ?? this.incomeTotal
      ..expensesTotal = expensesTotal ?? this.expensesTotal
      ..customizeParam = customizeParam ?? this.customizeParam;
  }
}

RankList $RankListFromJson(Map<String, dynamic> json) {
  final RankList rankList = RankList();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    rankList.id = id;
  }
  final String? excerpt = jsonConvert.convert<String>(json['excerpt']);
  if (excerpt != null) {
    rankList.excerpt = excerpt;
  }
  final String? bankCard = jsonConvert.convert<String>(json['bankCard']);
  if (bankCard != null) {
    rankList.bankCard = bankCard;
  }
  final String? transactionTime = jsonConvert.convert<String>(
      json['transactionTime']);
  if (transactionTime != null) {
    rankList.transactionTime = transactionTime;
  }
  final double? amount = jsonConvert.convert<double>(json['amount']);
  if (amount != null) {
    rankList.amount = amount;
  }
  return rankList;
}

Map<String, dynamic> $RankListToJson(RankList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['excerpt'] = entity.excerpt;
  data['bankCard'] = entity.bankCard;
  data['transactionTime'] = entity.transactionTime;
  data['amount'] = entity.amount;
  return data;
}

extension RankListExtension on RankList {
  RankList copyWith({
    int? id,
    String? excerpt,
    String? bankCard,
    String? transactionTime,
    double? amount,
  }) {
    return RankList()
      ..id = id ?? this.id
      ..excerpt = excerpt ?? this.excerpt
      ..bankCard = bankCard ?? this.bankCard
      ..transactionTime = transactionTime ?? this.transactionTime
      ..amount = amount ?? this.amount;
  }
}