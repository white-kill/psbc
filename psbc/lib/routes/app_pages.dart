
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/index/index_view.dart';
import '../pages/login/login_view.dart';
import '../pages/other/search/search_view.dart';
import '../pages/splash/splash_view.dart';
import '../pages/tabs/home/bill/bill_search/bill_search_view.dart';
import '../pages/tabs/home/bill/search_history/search_history_view.dart';
import '../pages/tabs/home/bill/year_bill/year_bill_info/year_bill_info_view.dart';
import '../pages/tabs/home/transfer/dzhd/dzhd_list/dzhd_info/dzhd_info_view.dart';
import '../pages/tabs/home/transfer/record/detail/detail_view.dart';
import '../pages/tabs/home/transfer/record/query_record/query_record_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.tabs,
      page: () => IndexPage(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.search,
      page: () => SearchPage(),
    ),
    GetPage(
      name: Routes.billSearchPage,
      page: () => BillSearchPage(),
    ),
    GetPage(
      name: Routes.searchHistoryPage,
      page: () => SearchHistoryPage(),
    ),
    GetPage(
      name: Routes.splashPage,
      page: () => SplashPage(),
    ),
    GetPage(
      name: Routes.transferDetailPage,
      page: () => TransferDetailPage(),
    ),
    GetPage(
      name: Routes.queryRecordPage,
      page: () => QueryRecordPage(),
    ),
    GetPage(
      name: Routes.yearBillInfoPage,
      page: () => YearBillInfoPage(),
    ),
    GetPage(
      name: Routes.dzhdInfoPage,
      page: () => DzhdInfoPage(),
    ),
  ];
}
