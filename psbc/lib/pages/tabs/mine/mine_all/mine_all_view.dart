import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/mine/mine_all/component/mine_all_top_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../component/placeholder_search_widget.dart';
import 'mine_all_logic.dart';
import 'mine_all_state.dart';

class MineAllPage extends BaseStateless {
  MineAllPage({Key? key}) : super(key: key);

  final Mine_allLogic logic = Get.put(Mine_allLogic());
  final Mine_allState state = Get.find<Mine_allLogic>().state;

  @override
  Color? get background => Colors.white;

  @override
  Widget? get titleWidget => PlaceholderSearchWidget(
        width: 245.w,
        contentList: const ['账单', '优惠活动', '明细查询'],
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
        textColor: Colors.black,
      );

  @override
  List<Widget>? get rightAction => [
        SizedBox(
          width: 10.w,
        ),
        Image(
          width: 38.w,
          height: 38.w,
          image: 'home_right_khfw'.png3x,
        ),
        SizedBox(
          width: 16.w,
        ),
      ];


  // 锚点功能：滚动到指定图片位置
  void _scrollToImage(BuildContext context, int imageIndex) {
    if (imageIndex < 0 || imageIndex >= state.imageKeys.length) {
      return;
    }
    
    // 设置标志，防止滚动过程中自动更新选中状态
    state.isScrollingToAnchor = true;
    state.selectedIndex = imageIndex;
    logic.update(['updateSelected']);
    
    final GlobalKey imageKey = state.imageKeys[imageIndex];
    final BuildContext? imageContext = imageKey.currentContext;
    
    if (imageContext != null) {
      // 计算导航栏高度，使锚点稍微往下一些
      final double navBarHeight = MediaQuery.of(context).padding.top + 44.w;
      final double screenHeight = MediaQuery.of(context).size.height;
      // alignment 设置为略小于0，使图片稍微往下
      final double alignment = navBarHeight / screenHeight;
      
      // 使用 Scrollable.ensureVisible 滚动到目标位置
      Scrollable.ensureVisible(
        imageContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: alignment, // 滚动后图片稍微往下，避开导航栏
      ).then((_) {
        // 滚动完成后，恢复自动更新
        Future.delayed(const Duration(milliseconds: 100), () {
          state.isScrollingToAnchor = false;
        });
      });
    } else {
      // 如果图片还没有渲染，延迟一下再尝试
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final BuildContext? retryContext = imageKey.currentContext;
        if (retryContext != null) {
          // 计算导航栏高度，使锚点稍微往下一些
          final double navBarHeight = MediaQuery.of(context).padding.top + 44.w;
          final double screenHeight = MediaQuery.of(context).size.height;
          final double alignment = navBarHeight / screenHeight;
          
          Scrollable.ensureVisible(
            retryContext,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: alignment,
          ).then((_) {
            Future.delayed(const Duration(milliseconds: 100), () {
              state.isScrollingToAnchor = false;
            });
          });
        } else {
          state.isScrollingToAnchor = false;
        }
      });
    }
  }

  // 计算 MineAllTopWidget 的高度
  double _calculateMineAllTopWidgetHeight() {
    // 标题 "最近使用" 部分
    final double titleTopPadding = 16.w;
    final double titleHeight = 20.w; // 字体大小16，行高约20
    final double titleSectionHeight = titleTopPadding + titleHeight;
    
    // VerticalGridView 部分
    final int itemCount = 8; // titles.length
    final int crossCount = 4; // 每行4个
    final double mainHeight = 55.w; // 每个item的高度
    final double spacing = 10.w; // 行间距
    final double gridTopPadding = 10.w;
    final double gridBottomPadding = 12.w;
    
    // 计算行数
    final int rowCount = (itemCount / crossCount).ceil(); // 8 / 4 = 2行
    
    // GridView 高度 = top padding + (行数 * item高度) + (行间距 * (行数-1)) + bottom padding
    final double gridViewHeight = gridTopPadding + 
        (rowCount * mainHeight) + 
        ((rowCount - 1) * spacing) + 
        gridBottomPadding;
    
    // 总高度 = 标题部分 + GridView部分
    final double totalHeight = titleSectionHeight + gridViewHeight;
    
    return totalHeight;
  }

  // 根据滚动位置更新选中索引（左右联动）
  void _updateSelectedIndex(BuildContext context) {
    // 如果正在执行锚点滚动，不更新选中状态
    if (state.isScrollingToAnchor) {
      return;
    }
    
    if (!state.outerScrollController.hasClients) {
      return;
    }
    
    // 计算导航栏高度，用于调整视口顶部位置
    final double navBarHeight = MediaQuery.of(context).padding.top + 100.w;
    
    // 计算当前应该选中的索引
    // 需要根据图片的实际位置来判断
    int newSelectedIndex = 0;
    double minDistance = double.infinity;
    
    // 遍历所有图片，找到当前视口中最接近顶部（考虑导航栏）的图片
    for (int i = 0; i < state.imageKeys.length; i++) {
      final GlobalKey imageKey = state.imageKeys[i];
      final RenderObject? renderObject = imageKey.currentContext?.findRenderObject();
      
      if (renderObject != null && renderObject is RenderBox) {
        final RenderBox? outerRenderBox = context.findRenderObject() as RenderBox?;
        if (outerRenderBox != null) {
          final Offset position = renderObject.localToGlobal(Offset.zero);
          final Offset outerPosition = outerRenderBox.localToGlobal(Offset.zero);
          // 计算图片相对于视口顶部（考虑导航栏）的位置
          final double relativePosition = position.dy - (outerPosition.dy + navBarHeight);
          
          // 计算图片顶部到视口顶部（考虑导航栏后）的距离
          final double distance = relativePosition.abs();
          
          // 如果图片在视口内或接近视口顶部，记录距离
          // 调整判断范围，考虑导航栏高度
          final double screenHeight = MediaQuery.of(context).size.height;
          if (relativePosition >= -100 && relativePosition <= screenHeight - navBarHeight) {
            if (distance < minDistance) {
              minDistance = distance;
              newSelectedIndex = i;
            }
          }
        }
      }
    }
    
    // 如果索引发生变化，更新状态
    if (state.selectedIndex != newSelectedIndex) {
      state.selectedIndex = newSelectedIndex;
      logic.update(['updateSelected']);
      // 滚动左侧列表，确保选中项可见
      _scrollLeftListToSelected(context);
    }
  }

  // 滚动左侧列表，确保选中项可见
  void _scrollLeftListToSelected(BuildContext context) {
    if (!state.leftScrollController.hasClients) {
      return;
    }

    // 估算每个item的高度：top(15.w) + text + spacing(5.w) + indicator(4.w) + bottom(5.w)
    // 假设文本高度约20.w，总高度约49.w，为保险起见使用50.w
    final double itemHeight = 50.w;
    final int selectedIndex = state.selectedIndex;
    
    // 计算选中项的起始位置
    final double targetOffset = selectedIndex * itemHeight;
    
    // 获取当前可视区域的高度（左侧A列表的高度）
    final double visibleHeight = MediaQuery.of(context).size.height - 
        (MediaQuery.of(context).padding.top + 44.w);
    
    // 获取当前滚动位置
    final double currentOffset = state.leftScrollController.offset;
    
    // 判断选中项是否在可视区域内
    // 如果选中项在可视区域上方，滚动到选中项顶部
    if (targetOffset < currentOffset) {
      state.leftScrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } 
    // 如果选中项在可视区域下方，滚动到选中项底部对齐视口底部
    else if (targetOffset + itemHeight > currentOffset + visibleHeight) {
      final double targetScrollOffset = targetOffset + itemHeight - visibleHeight;
      state.leftScrollController.animateTo(
        targetScrollOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    // 选中项已在可视区域内，不需要滚动
  }

  @override
  Widget initBody(BuildContext context) {
    // 监听外层滚动位置变化，更新悬停位置和选中索引
    state.outerScrollController.addListener(() {
      logic.update(['updateSticky']);
      _updateSelectedIndex(context);
    });
    
    // 在布局完成后，更新一次悬停位置，确保初始状态正确
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.update(['updateSticky']);
      _updateSelectedIndex(context);
    });
    
    return GetBuilder<Mine_allLogic>(
      id: 'updateSticky',
      builder: (_) {
        // 计算左侧 A 的悬停位置
        double stickyHeaderTop = 0.0;
        
        // 计算顶部内容的高度（图片 + 分隔线 + 最近使用 + 分隔线）
        // 图片尺寸：1080 x 126，根据屏幕宽度计算实际高度
        final double screenWidth = MediaQuery.of(context).size.width;
        final double imageHeight = (126 / 1080) * screenWidth; // 根据图片比例计算高度
        final double separatorHeight = 8.w;
        final double mineAllTopWidgetHeight = _calculateMineAllTopWidgetHeight();
        final double topContentHeight = imageHeight + separatorHeight + 
            mineAllTopWidgetHeight + separatorHeight;
        
        if (state.outerScrollController.hasClients) {
          final double scrollOffset = state.outerScrollController.offset;
          
          // 如果滚动超过顶部内容，让左侧 A 悬停在顶部
          if (scrollOffset > topContentHeight) {
            stickyHeaderTop = 0.0; // 悬停在顶部
          } else {
            stickyHeaderTop = topContentHeight - scrollOffset; // 跟随滚动
          }
        } else {
          // 初始状态下，还没有滚动，应该显示在原始位置
          stickyHeaderTop = topContentHeight;
        }
        
        return Stack(
          children: [
            // 外层 ListView
            ListView(
              controller: state.outerScrollController,
              padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight + 20.w),
              children: [
                // 顶部图片 - 参与外层滚动
                Image(
                  image: 'main_all_top'.png3x,
                ),
                // 分隔线
                Container(
                  height: 8.w,
                  color: const Color(0xFFF5F5F5),
                ),
                // 最近使用部分 - 参与外层滚动
                const MineAllTopWidget(),
                // 分隔线
                Container(
                  height: 8.w,
                  color: const Color(0xFFF5F5F5),
                ),
                // 左右分栏部分 - 假的占位
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 左侧 A 部分 - 假占位
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        // 占位，不显示内容
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: 1.w,
                      color: Color(0xFFDADADA),
                      margin: EdgeInsets.symmetric(vertical: 20.w),
                    ),
                    // 右侧 B 部分 - 使用 ListView 可以垂直滚动，不设置固定高度
                    Expanded(
                      flex: 3,
                      child: ListView(
                        controller: state.rightScrollController,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Image(
                            key: state.imageKeys[0],
                            image: 'main_all_bottom2'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[1],
                            image: 'main_all_bottom3'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[2],
                            image: 'main_all_bottom4'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[3],
                            image: 'main_all_bottom5'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[4],
                            image: 'main_all_bottom6'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[5],
                            image: 'main_all_bottom7'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[6],
                            image: 'main_all_bottom8'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[7],
                            image: 'main_all_bottom9'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[8],
                            image: 'main_all_bottom10'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[9],
                            image: 'main_all_bottom11'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[10],
                            image: 'main_all_bottom12'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[11],
                            image: 'main_all_bottom13'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[12],
                            image: 'main_all_bottom14'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[13],
                            image: 'main_all_bottom15'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[14],
                            image: 'main_all_bottom16'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[15],
                            image: 'main_all_bottom17'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[16],
                            image: 'main_all_bottom18'.png,
                            fit: BoxFit.fitWidth,
                          ),
                          Image(
                            key: state.imageKeys[17],
                            image: 'main_all_bottom19'.png,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // 左侧 A 部分 - 使用 Positioned 实现悬停，作为锚点功能
            Positioned(
              left: 0,
              top: stickyHeaderTop,
              width: (MediaQuery.of(context).size.width / 4), // flex: 1 的宽度
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + 44.w),
              child: GetBuilder<Mine_allLogic>(
                id: 'updateSelected',
                builder: (_) => ListView.builder(
                  controller: state.leftScrollController,
                  itemCount: state.leftListTexts.length, // 对应文案数量
                  itemBuilder: (context, index) {
                    final bool isSelected = state.selectedIndex == index;
                    return Container(
                      // height: 50.w,
                      margin: EdgeInsets.only(top: 15.w, bottom: 5.w),
                      child: Column(
                        children: [
                          // 文字
                          Container(
                            child: Text(
                              state.leftListTexts[index],
                              style: TextStyle(
                                color: isSelected ? const Color(0xFF26805D) : const Color(0xFF504E4F),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.w,),
                          // 选中时的 indicator 图片
                          if (isSelected)
                            Image(
                              image: 'indicator'.png,
                              width: 20.w,
                              height: 4.w,
                            )
                          else
                            SizedBox(height: 4.w,),


                        ],
                      ),
                    ).withOnTap(onTap: () {
                      // 锚点功能：点击后滚动到对应的图片位置
                      state.selectedIndex = index;
                      logic.update(['updateSelected']);
                      _scrollToImage(context, index);
                      // 滚动左侧列表，确保选中项可见
                      _scrollLeftListToSelected(context);
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
