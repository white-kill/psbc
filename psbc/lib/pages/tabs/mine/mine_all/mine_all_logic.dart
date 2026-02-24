import 'package:get/get.dart';

import 'mine_all_state.dart';

class Mine_allLogic extends GetxController {
  final Mine_allState state = Mine_allState();
  
  @override
  void onClose() {
    state.dispose();
    super.onClose();
  }
}
