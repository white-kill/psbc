import 'package:psbc/generated/json/base/json_field.dart';
import 'package:psbc/generated/json/rank_model.g.dart';
import 'dart:convert';
export 'package:psbc/generated/json/rank_model.g.dart';

@JsonSerializable()
class RankModel {
	List<RankList> list = [];
	int total = 0;
	dynamic pages;
	String incomeTotal = '';
	String expensesTotal = '';
	dynamic customizeParam;

	RankModel();

	factory RankModel.fromJson(Map<String, dynamic> json) => $RankModelFromJson(json);

	Map<String, dynamic> toJson() => $RankModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class RankList {
	int id = 0;
	String excerpt = '';
	String bankCard = '';
	String transactionTime = '';
	double amount = 0;

	RankList();

	factory RankList.fromJson(Map<String, dynamic> json) => $RankListFromJson(json);

	Map<String, dynamic> toJson() => $RankListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}