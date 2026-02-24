import 'package:get/get.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/model/receipt_model.dart';
import 'package:psbc/config/net_config/apis.dart';

import '../dzhd_info/dzhd_info_view.dart';
import 'dzhd_verification_state.dart';

class Dzhd_verificationLogic extends GetxController {
  final Dzhd_verificationState state = Dzhd_verificationState();

  var show =false.obs;

  void checkReceipt(){
    Http.post(Apis.checkReceipt,data: {
      "no":state.text1,
      "realName":state.text2
    }).then((v){
      ReceiptListDetail model = ReceiptListDetail.fromJson(v);
      Get.to(() => DzhdInfoPage(),arguments: {
        'model':model
      });
    });
  }
}
