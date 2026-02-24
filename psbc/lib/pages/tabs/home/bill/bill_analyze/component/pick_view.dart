import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/abc_button.dart';
import '../bill_analyze_logic.dart';
import '../bill_analyze_state.dart';

class CupertinoTypePicker extends StatefulWidget {
  const CupertinoTypePicker({super.key});

  @override
  _CupertinoTypePickerState createState() => _CupertinoTypePickerState();
}

class _CupertinoTypePickerState extends State<CupertinoTypePicker> {
  String _selectedType = '月度';
  final List<String> _genders = ['年度', '月度'];

  final BillAnalyzeLogic logic = Get.find<BillAnalyzeLogic>();
  final BillAnalyzeState state = Get.find<BillAnalyzeLogic>().state;
  FixedExtentScrollController scrollController = FixedExtentScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedType = state.selectedTimeType;
    WidgetsBinding.instance.addPostFrameCallback((_){
      scrollController.jumpToItem(_genders.indexOf(_selectedType));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: [
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: scrollController,
              selectionOverlay: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.w, color: const Color(0xFFE7E7E7)),
                    bottom: BorderSide(
                        width: 1.w, color: const Color(0xFFE7E7E7)), // 下边框
                  ),
                ),
              ),
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedType = _genders[index];
                });
              },
              children: _genders.map((gender) {
                return Center(
                  child: Text(
                    gender,
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }).toList(),
            ),
          ),
          AbcButton(
            title: '确定',
            width: 345.w,
            height: 45.w,
            radius: 4.w,
            onTap: () {
              state.selectedTimeType = _selectedType;
              if(state.selectedTimeType == '月度'){
                state.dateTime = DateFormat('yyyy-MM').format(DateTime.now());
              }
              if(state.selectedTimeType == '年度'){
                state.dateTime = DateFormat('yyyy').format(DateTime.now());
              }
              logic.update(['updateTop']);
              Get.back();
              logic.billAnalysis();
            },
          ),
        ],
      ),
    );
  }
}
