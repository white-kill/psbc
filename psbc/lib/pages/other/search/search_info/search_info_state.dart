import 'package:flutter/cupertino.dart';

class SearchInfoState {


  List<String> titles = [
    '全部',
    '功能',
    '产品',
    '生活',
    '帮助'
  ];

  List list1 = [
    '账户明细打印',
    '明细查询',
  ];

  List list2 = [
    {
      'title':'账户明细打印',
      'content':'首页>财富>账户>账户明细打印',
    },
    {
      'title':'明细查询',
      'content':'全部>账户>明细查询',
    },
    {
      'title':'国债交易明细',
      'content':'首页>财富>国债>我的债券>国债交易明细',
    },
  ];

  TextEditingController searchController = TextEditingController();

  SearchInfoState() {
    ///Initialize variables
  }
}
