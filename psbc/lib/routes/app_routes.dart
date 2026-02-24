part of 'app_pages.dart';

class Routes {
  Routes._();

  static const tabs = '/tabs';

  static const login = '/login';

  static const search = '/search';

  static const billSearchPage = '/billSearchPage';

  static const searchHistoryPage = '/searchHistoryPage';

  static const splashPage = '/splashPage';

  static const transferDetailPage = '/transferDetailPage';

  static const queryRecordPage = '/queryRecordPage';

  static const yearBillInfoPage = '/yearBillInfoPage';

  static const dzhdInfoPage = '/dzhdInfoPage';


}
extension RoutesStringExtension on String {
  Future? get push => Get.toNamed(this);
}
