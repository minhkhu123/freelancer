import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/routes/app_routes.dart';
import 'package:freelancer_app/screens/authens/intro/intro_content.dart';
import 'package:freelancer_app/screens/authens/intro/intro_controller.dart';
import 'package:freelancer_app/screens/authens/intro/loading/loading_controller.dart';
import 'package:get/get.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = Get.put(LoadingController());
    return SafeArea(
        child: Scaffold(
      body: GetBuilder<IntroController>(
        init: IntroController(),
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(Images.top_intro),
              ],
            ),
            Expanded(
              flex: 6,
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (int index) {
                  controller.currentPageNotifier.value = index;
                },
                children: [
                  IntroContent(
                    text: 'Đáp ứng nhu cầu tìm việc ngay lập tức',
                    image: Images.logo_intro_1,
                    onPress: () {
                      if (controller.pageController.page.toInt() < controller.count.value - 1) {
                        controller.pageController.animateToPage(controller.pageController.page.toInt() + 1,
                            duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                        print(controller.pageController.page.toInt());
                      }
                      if (controller.pageController.page.toInt() == 2) {
                        loadingController.checkIntro.value = true;
                        loadingController.checkIntroBool();
                        Get.offAllNamed(Routes.WAIT_LOGIN_1);
                      }
                    },
                  ),
                  IntroContent(
                    text: 'Hỗ trợ 24/7',
                    image: Images.logo_intro_2,
                    onPress: () {
                      if (controller.pageController.page.toInt() < controller.count.value - 1) {
                        controller.pageController.animateToPage(controller.pageController.page.toInt() + 1,
                            duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                        print(controller.pageController.page.toInt());
                      }
                      if (controller.pageController.page.toInt() == 2) {
                        loadingController.checkIntro.value = true;
                        loadingController.checkIntroBool();
                        Get.offAllNamed(Routes.WAIT_LOGIN_1);
                      }
                    },
                  ),
                  IntroContent(
                    text: 'Lọc làm phù hợp với bạn',
                    image: Images.logo_intro_3,
                    onPress: () {
                      if (controller.pageController.page.toInt() < controller.count.value - 1) {
                        controller.pageController.animateToPage(controller.pageController.page.toInt() + 1,
                            duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                        print(controller.pageController.page.toInt());
                      }
                      if (controller.pageController.page.toInt() == 2) {
                        loadingController.checkIntro.value = true;
                        loadingController.checkIntroBool();
                        Get.offAllNamed(Routes.WAIT_LOGIN_1);
                      }
                    },
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CirclePageIndicator(
                size: 8,
                dotColor: AppColors.whiteDot,
                selectedDotColor: AppColors.blue,
                selectedSize: 8,
                itemCount: controller.count.value,
                currentPageNotifier: controller.currentPageNotifier,
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(Images.bottom_intro),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: InkWell(
                    onTap: () {
                      loadingController.checkIntro.value = true;
                      loadingController.checkIntroBool();
                      Get.offAllNamed(Routes.WAIT_LOGIN_1);
                    },
                      child: Text('BỎ QUA',style: AppTextStyles.regularW700(context, size: 14,color: AppColors.orange),)),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
