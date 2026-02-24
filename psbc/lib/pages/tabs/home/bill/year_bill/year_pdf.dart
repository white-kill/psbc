import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pdfx/pdfx.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../component/right_widget.dart';

class YearPdfWidget extends BaseStateless {
  const YearPdfWidget({
    super.key,
  }) : super(title: '个人年度账单服务客户授权书');

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get background => Colors.white;
  @override
  Widget initBody(BuildContext context) {
    return  PdfView(
        scrollDirection:Axis.vertical,
        controller:PdfController(
          document: PdfDocument.openAsset('assets/pdf/year_bill.pdf'),
        ));
  }
}
