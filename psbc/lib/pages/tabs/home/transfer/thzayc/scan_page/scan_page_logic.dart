import 'package:get/get.dart';

import 'scan_page_state.dart';

class ScanPageLogic extends GetxController {
  final ScanPageState state = ScanPageState();

  @override
  void onClose() {
    state.controller?.dispose();
    super.onClose();
  }
}
