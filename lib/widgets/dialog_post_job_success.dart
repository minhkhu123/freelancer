import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/message_posted/message_posted_screen.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:get/get.dart';

class DialogPostJobSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterController registerController = Get.put(RegisterController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Dialog(
        insetPadding: EdgeInsets.only(top: 10.0),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(horizontal: 14),
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 268,
          width: width,
          child: GetBuilder<MenuController>(
            init: MenuController(),
            builder: (controller) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      SizedBox(width: width*0.23),
                      Text(
                        'Thông báo',
                        style: AppTextStyles.regularW500(context, size: 20, color: AppColors.black2),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {Get.back();},
                          child: Icon(Icons.clear)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(Images.ic_post_job_success),
                    SizedBox(width: 17),
                    Text('Đăng việc làm thành công',style: AppTextStyles.regularW500(context, size: 17,color: AppColors.blue4),),
                  ],
                ),
                SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Bạn đã đăng việc làm thành công. Nhấn",
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: AppColors.black,height: 1.4)
                      ),
                      TextSpan(
                        text: " Tiếp tục ",
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.orange,height: 1.4)
                      ),
                      TextSpan(
                        text: "để đăng việc làm khác",
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: AppColors.black,height: 1.4)
                      ),
                    ]),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // controller.clearList();
                        controller.clearList();
                        registerController.searchCategoryTextEditingController.clear();
                        registerController.getSearchListCategory();
                        registerController.searchWorkPlaceTextEditingController.clear();
                        registerController.getSearchListWorkPlace();
                        Get.back();
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text('Tiếp tục',style: AppTextStyles.regularW700(context, size: 15),)),
                      ),
                    ),
                    SizedBox(width: 9),
                    InkWell(
                      onTap: () {
                        Get.to(MessagePostedScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.blue4,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text('Tin đã đăng',style: AppTextStyles.regularW700(context, size: 15),)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
