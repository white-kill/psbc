import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/abc_button.dart';
import '../../../../../component/sheet_widget/picker_widget.dart';
import 'analyze_rank_logic.dart';
import 'analyze_rank_state.dart';

class PickRankTimeView extends StatefulWidget {
  const PickRankTimeView({super.key});

  @override
  State<PickRankTimeView> createState() => _PickTimeViewState();
}

class _PickTimeViewState extends State<PickRankTimeView> {

  final AnalyzeRankLogic logic = Get.find<AnalyzeRankLogic>();
  final AnalyzeRankState state = Get.find<AnalyzeRankLogic>().state;

  String _selectedtime = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 180.w,
          child: DateTimePicker(
            dateTimePickerNotifier: state.pickerNotifier,
            showDay: false,
            onDateTimeChanged: (DateTime date) {
              _selectedtime = DateFormat('yyyy-MM').format(date);
            },
          ),
        ),

        AbcButton(
          title: '确定',
          width: 345.w,
          height: 45.w,
          radius: 4.w,
          onTap: () {
            state.dateTime = _selectedtime;
            logic.update(['updateTop']);
            Get.back();
            logic.incomeAnalysisRank();
          },
        ),
      ],
    );
  }
}
