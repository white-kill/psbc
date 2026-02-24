import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final DateTime? minDateTime; // 最小时间限制
  final ValueChanged<DateTime>? onDateTimeChanged;
  final DateTimePickerNotifier? dateTimePickerNotifier;
  final bool showText;
  final bool showDay;
  final bool showMonth;
  final int lastYear;
  const DateTimePicker({
    super.key,
    this.initialDateTime,
    this.minDateTime, // 新增最小时间参数
    this.onDateTimeChanged,
    this.dateTimePickerNotifier,
    this.showText = true,
    this.showDay = true,
    this.showMonth = true,
    this.lastYear = 5,
  });

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;

  late int _selectedYear;
  late int _selectedMonth;
  late int _selectedDay;

  final DateTime _currentDate = DateTime.now();
  int _startYear = 2025;

   bool showDay = true;

  @override
  void initState() {
    super.initState();

    showDay = widget.showDay;
    var initialDate = widget.initialDateTime ?? _currentDate;

    // 若有最小时间限制且初始时间早于最小时间，则使用最小时间
    if (widget.minDateTime != null && initialDate.isBefore(widget.minDateTime!)) {
      initialDate = widget.minDateTime!;
    }

    _selectedYear = initialDate.year;
    _selectedMonth = initialDate.month;
    _selectedDay = initialDate.day;

    // 起始年份：若有 minDateTime 则取「当前年 - lastYear」与「最小年份」中更早的（取更小的）
    final baseStartYear = _currentDate.year - widget.lastYear;
    _startYear = widget.minDateTime != null
        ? (baseStartYear < widget.minDateTime!.year ? baseStartYear : widget.minDateTime!.year)
        : baseStartYear;

    _yearController =
        FixedExtentScrollController(initialItem: _selectedYear - _startYear);

    // 计算月份的初始索引
    final months = getMonths();
    final monthIndex = months.indexOf(_selectedMonth);
    _monthController =
        FixedExtentScrollController(initialItem: monthIndex >= 0 ? monthIndex : 0);

    // 计算日期的初始索引
    final days = getDays();
    final dayIndex = days.indexOf(_selectedDay);
    _dayController = FixedExtentScrollController(initialItem: dayIndex >= 0 ? dayIndex : 0);

    widget.dateTimePickerNotifier?.addListener(_onController);
  }
  _onController() {
    if (mounted) {
      if (widget.dateTimePickerNotifier?.type == "jumpTime") {
        jumpToDate(widget.dateTimePickerNotifier?.jTime??DateTime.now());
      }
      if (widget.dateTimePickerNotifier?.type == "changeTimeType") {
        showDay = widget.dateTimePickerNotifier!.showDay;
        setState(() {});
      }
    }
  }


  void jumpToDate(DateTime date) {
    final years = getYears();
    final yearIndex = years.indexOf(date.year);
    if (yearIndex != -1) {
      _yearController.jumpToItem(yearIndex);
      _selectedYear = date.year;
    }

    final months = getMonths();
    final monthIndex = months.indexOf(date.month);
    if (monthIndex != -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _monthController.jumpToItem(monthIndex);
      });
      _selectedMonth = date.month;
    }

    final days = getDays();
    final dayIndex = days.indexOf(date.day);
    if (dayIndex != -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _dayController.jumpToItem(dayIndex);
      });
      _selectedDay = date.day;
    }

    _notifyDateTimeChanged();
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  List<int> getYears() {
    return List.generate(
        _currentDate.year - _startYear + 1, (index) => _startYear + index);
  }

  List<int> getMonths() {
    int minMonth = 1; // 默认最小月份为1月
    int maxMonth = 12; // 默认最大月份为12月
    
    // 如果有最小时间限制，且当前选中年份等于最小时间的年份
    if (widget.minDateTime != null && _selectedYear == widget.minDateTime!.year) {
      minMonth = widget.minDateTime!.month;
    }
    
    // 如果选中年份是当前年份，最大月份为当前月份
    if (_selectedYear == _currentDate.year) {
      maxMonth = _currentDate.month;
    }
    
    // 返回从minMonth到maxMonth的月份列表
    return List.generate(maxMonth - minMonth + 1, (index) => minMonth + index);
  }

  List<int> getDays() {
    int minDay = 1; // 默认最小日期为1号
    int maxDay;
    
    // 如果有最小时间限制，且当前选中年月等于最小时间的年月
    if (widget.minDateTime != null &&
        _selectedYear == widget.minDateTime!.year &&
        _selectedMonth == widget.minDateTime!.month) {
      minDay = widget.minDateTime!.day;
    }
    
    // 如果选中年月是当前年月，最大日期为当前日期
    if (_selectedYear == _currentDate.year &&
        _selectedMonth == _currentDate.month) {
      maxDay = _currentDate.day;
    } else {
      // 否则最大日期为该月的最后一天
      maxDay = DateTime(_selectedYear, _selectedMonth + 1, 0).day;
    }
    
    // 返回从minDay到maxDay的日期列表
    return List.generate(maxDay - minDay + 1, (index) => minDay + index);
  }

  void _onYearSelected(int index) {
    final years = getYears();
    setState(() {
      _selectedYear = years[index];
      // 检查月份是否超出范围
      final months = getMonths();
      if (!months.contains(_selectedMonth)) {
        // 如果当前选中的月份不在可用月份列表中，选择第一个可用月份
        _selectedMonth = months.first;
        _monthController.jumpToItem(0);
      } else {
        // 更新月份控制器的位置（因为可用月份列表可能改变了起始位置）
        final monthIndex = months.indexOf(_selectedMonth);
        _monthController.jumpToItem(monthIndex);
      }
      // 检查日期是否超出范围
      final days = getDays();
      if (!days.contains(_selectedDay)) {
        _selectedDay = days.first;
        _dayController.jumpToItem(0);
      } else {
        final dayIndex = days.indexOf(_selectedDay);
        _dayController.jumpToItem(dayIndex);
      }
    });
    _notifyDateTimeChanged();
  }

  void _onMonthSelected(int index) {
    final months = getMonths();
    setState(() {
      _selectedMonth = months[index]; // 使用实际的月份值，而不是index + 1
      // 检查日期是否超出范围
      final days = getDays();
      if (!days.contains(_selectedDay)) {
        _selectedDay = days.first;
        _dayController.jumpToItem(0);
      } else {
        final dayIndex = days.indexOf(_selectedDay);
        _dayController.jumpToItem(dayIndex);
      }
    });
    _notifyDateTimeChanged();
  }

  void _onDaySelected(int index) {
    final days = getDays();
    setState(() {
      _selectedDay = days[index]; // 使用实际的日期值
    });
    _notifyDateTimeChanged();
  }

  void _notifyDateTimeChanged() {
    if (widget.onDateTimeChanged != null) {
      widget.onDateTimeChanged!(
          DateTime(_selectedYear, _selectedMonth, _selectedDay));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CupertinoPicker(
            scrollController: _yearController,
            itemExtent: 42.w,
            onSelectedItemChanged: _onYearSelected,
            // selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            //   capStartEdge: false,
            //   capEndEdge: false,
            // ),
            selectionOverlay: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.w, color: const Color(0xFFE7E7E7)),
                  bottom: BorderSide(
                      width: 1.w, color: const Color(0xFFE7E7E7)), // 下边框
                ),
              ),
            ),
            children: getYears().map((year) {
              return Center(
                child: Text(
                  widget.showText?'$year年':year.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        // 月选择器
       widget.showMonth? Expanded(
          child: CupertinoPicker(
            scrollController: _monthController,
            itemExtent: 42.w,
            onSelectedItemChanged: _onMonthSelected,
            // selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            //   capStartEdge: false,
            //   capEndEdge: false,
            // ),
            selectionOverlay: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.w, color: const Color(0xFFE7E7E7)),
                  bottom: BorderSide(
                      width: 1.w, color: const Color(0xFFE7E7E7)), // 下边框
                ),
              ),
            ),
            children: getMonths().map((month) {
              return Center(
                child: Text(
                  widget.showText
                      ? '${month.toString().padLeft(2, '0')}月'
                      : month.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ):const SizedBox.shrink(),
        // 日选择器
        showDay? Expanded(
          child: CupertinoPicker(
            scrollController: _dayController,
            itemExtent: 42.w,
            onSelectedItemChanged: _onDaySelected,
            // selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            //   capStartEdge: false,
            //   capEndEdge: false,
            // ),
            selectionOverlay: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.w, color: const Color(0xFFE7E7E7)),
                  bottom: BorderSide(
                      width: 1.w, color: const Color(0xFFE7E7E7)), // 下边框
                ),
              ),
            ),
            children: getDays().map((day) {
              return Center(
                child: Text(
                  widget.showText
                      ? '${day.toString().padLeft(2, '0')}日'
                      : day.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ):const SizedBox.shrink(),
      ],
    );
  }
}


class DateTimePickerNotifier extends ChangeNotifier {

  String type = '';

  DateTime? jTime;
  jumpTime(DateTime t) {
    type = 'jumpTime';
    jTime = t;
    notifyListeners();
  }

  bool showDay = true;
  changeTimeType(bool show){
    type = 'changeTimeType';
    showDay = show;
    notifyListeners();
  }

}

