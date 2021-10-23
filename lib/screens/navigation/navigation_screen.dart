import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class NavigationScreen extends StatefulWidget {
  final Widget widget;

  const NavigationScreen({Key key, this.widget}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  NavigationController navigationController = Get.put(NavigationController());
  @override
  void initState() {
    navigationController.loginIn = SpUtil.getBool(ConstString.LOGIN_IN);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) => DefaultTabController(
        length: 5,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabBar(
                      onTap: (value) => controller.changePage(value),
                      controller: controller.tabController,
                      tabs: [
                        new Tab(icon: controller.pageIndex.value == 0 ? SvgPicture.asset(Images.ic_home_bar_light) : SvgPicture.asset(Images.ic_home_bar)),
                        new Tab(icon: controller.pageIndex.value == 1 ? SvgPicture.asset(Images.ic_local_bar_light) : SvgPicture.asset(Images.ic_local_bar)),
                        new Tab(icon: controller.pageIndex.value == 2 ? SvgPicture.asset(Images.ic_chat_bar_light) : SvgPicture.asset(Images.ic_chat_bar)),
                        new Tab(icon: controller.pageIndex.value == 3 ? SvgPicture.asset(Images.ic_profile_bar_light) : SvgPicture.asset(Images.ic_profile_bar)),
                        new Tab(icon: controller.pageIndex.value == 4 ? SvgPicture.asset(Images.ic_menu_bar_light) : SvgPicture.asset(Images.ic_menu_bar)),
                      ],
                    )
                  ],
                ),
              ),
            body: NavigationController.to.currentPage.value
            ),
          ),
        ),
    );
  }
}
