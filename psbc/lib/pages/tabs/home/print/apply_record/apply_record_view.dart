import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/tabs/home/print/apply_record/pdf_download.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/apply_record_model.dart';
import '../../../../component/right_widget.dart';
import 'apply_record_logic.dart';
import 'apply_record_state.dart';

class ApplyRecordPage extends BaseStateless {
  ApplyRecordPage({Key? key}) : super(key: key, title: '申请记录');

  final ApplyRecordLogic logic = Get.put(ApplyRecordLogic());
  final ApplyRecordState state = Get.find<ApplyRecordLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  bool get enablePullDown => false;

  @override
  Widget initBody(BuildContext context) {
    return GetBuilder(
      builder: (ApplyRecordLogic c) {
        return refreshWidget(
            controller: state.refreshController,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 12.w, left: 12.w, right: 12.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.w))),
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BaseText(
                                text: '历史明细查询打印',
                                fontSize: 14,
                              ),
                              SizedBox(
                                height: 8.w,
                              ),
                              BaseText(
                                text: AppConfig.config.abcLogic.card(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 45.w,
                            height: 24.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.w)),
                                border: Border.all(
                                    color: BColors.mainColor, width: 0.5.w)),
                            child: BaseText(
                              text:state.list[index].email == ''?'已完成':'已发送',
                              fontSize: 12,
                              color: BColors.mainColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12.w,
                      ),
                      Container(
                        width: 1.sw,
                        height: 0.5.w,
                        color: Color(0xffdedede),
                      ),
                      SizedBox(
                        height: 12.w,
                      ),
                      ..._widgetList(state.list[index]),
                    ],
                  ),
                );
              },
              itemCount: state.list.length,
            ));
      },
      id: 'updateUI',
    );
  }

  List<Widget> _widgetList(ApplyRecordList model) {
    List _temTitles = [];
    _temTitles.addAll(model.email == ''?state.titles1 :state.titles);
    return _temTitles.map((e) {
      return Container(
        // padding: EdgeInsets.only(left: 12.w, right: 15.w),
        margin: EdgeInsets.only(top: 8.w, bottom: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           e == ''?_tipsWidget():BaseText(
              text: e,
              color: Color(0xff8D8D8D),
            ),


           e== ''? Container(
             width: 75.w,
             height: 30.w,
             alignment: Alignment.center,
             decoration: BoxDecoration(
                 borderRadius:
                 BorderRadius.all(Radius.circular(4.w)),
                 border: Border.all(
                     color:Color(0xff666666), width: 0.5.w)),
             child: FutureBuilder<bool>(
               future: PdfDownloadService.isFileDownloaded(model.fileUrl), // 调用你的判断方法
               builder: (context, snapshot) {
                 // 2. 获取结果（默认未下载为 false）
                 bool isExist = snapshot.data ?? false;
                 return BaseText(
                   text:isExist?'打开文件':'下载本地',
                   fontSize: 12,
                   color:Color(0xff666666),
                 ).withOnTap(onTap: (){
                   ''.showLoading;
                   PdfDownloadService.handlePdfAction(model.fileUrl).then((_){
                     SmartDialog.dismiss(status: SmartStatus.loading);
                     logic.update(['updateUI']);
                   });
                 });
               },
             ),
           ):Row(
              children: [
                BaseText(
                  text: logic.valueStr(e, model),
                  color: Color(0xff212121),
                ),
                e == '文件提取码'
                    ? Image(
                  image:model.isShow?'copy'.png:'yanj'.png,
                  width: 16.w,
                  height: 16.w,
                ).withContainer(
                    padding: EdgeInsets.only(left: 6.w),
                    onTap: ()async{
                      if(model.isShow)  {
                        await Clipboard.setData(ClipboardData(text: model.code ));
                        '复制成功'.showToast;
                      }
                      if(model.isShow == false){
                        model.isShow = true;
                      }
                      logic.update(['updateUI']);
                    }
                ) : const SizedBox.shrink()
              ],
            ),

          ],
        ),
      );
    }).toList();
  }


  Widget _tipsWidget(){
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(Get.context!).style,
        children: const [
          TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red,fontSize: 12),
          ),
          TextSpan(text: '文件有效期为',
            style: TextStyle(color: Color(0xff666666),fontSize: 12),
          ),
          TextSpan(
            text: '3',
            style: TextStyle(color: Colors.red,fontSize: 12),
          ),
          TextSpan(text: '天，过期请重新申请',
            style: TextStyle(color: Color(0xff666666),fontSize: 12),
          ),
        ],
      ),
    );
  }
}
