import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/abc_button.dart';
import '../../../../../component/sheet_widget/picker_widget.dart';
import '../bill_analyze_logic.dart';
import '../bill_analyze_state.dart';

class PickTimeView extends StatefulWidget {
  const PickTimeView({super.key});

  @override
  State<PickTimeView> createState() => _PickTimeViewState();
}

class _PickTimeViewState extends State<PickTimeView> {

  final BillAnalyzeLogic logic = Get.find<BillAnalyzeLogic>();
  final BillAnalyzeState state = Get.find<BillAnalyzeLogic>().state;

  String _selectedtime = '';

  @override
  void initState() {
    super.initState();
    // 初始化为当前日期
    DateTime now = DateTime.now();
    if (state.selectedTimeType == '月度') {
      _selectedtime = DateFormat('yyyy-MM').format(now);
    } else if (state.selectedTimeType == '年度') {
      _selectedtime = DateFormat('yyyy').format(now);
    }
  }

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
            showMonth: state.selectedTimeType == '月度',
            onDateTimeChanged: (DateTime date) {
              if(state.selectedTimeType == '月度'){
                _selectedtime = DateFormat('yyyy-MM').format(date);
              }
              if(state.selectedTimeType == '年度'){
                _selectedtime = DateFormat('yyyy').format(date);
              }

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
            logic.billAnalysis();
          },
        ),
      ],
    );
  }
}
