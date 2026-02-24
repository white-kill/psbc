import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../../config/model/rank_model.dart';
import '../../../../../component/sheet_widget/picker_widget.dart';

class AnalyzeRankState {
  int pageNum = 1;
  String type = '1';
  String dateTime = '';
  RefreshController refreshController = RefreshController();
  ScrollController scController = ScrollController();
  RankModel rankModel = RankModel();
  List<RankList> list = [];
  DateTimePickerNotifier pickerNotifier = DateTimePickerNotifier();
  AnalyzeRankState() {
    ///Initialize variables
  }
}
