import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/login/login_screen.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import '../screens/menu/detail_job_posted.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:get/get.dart';

import 'career_freelancer.dart';

class MineCardJobFreelancer extends StatelessWidget {
  final String career;
  final String urlLogo;
  final bool check;
  final String name;
  final String address;
  final String money;
  final String turnedDeal;
  final String dateEnd;
  final String linkLogo;
  final VoidCallback onPress;
  final List<String> listSkill;

  const MineCardJobFreelancer({Key key, this.career, this.check, this.urlLogo, this.linkLogo, this.name, this.address, this.dateEnd, this.turnedDeal, this.money, this.onPress, this.listSkill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
      ),
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: onPress,
                  child: CachedNetworkImage(
                    imageUrl:
                    urlLogo,
                    height: 67,
                    width: 67,
                    placeholder: (context, url) => SizedBox(child: CircularProgressIndicator(),width: 67,height: 67,),
                    errorWidget: (context, url, error) => SvgPicture.asset(Images.logo_freelancer),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: onPress,
                      child: Container(
                          width: width * 0.58,
                          child: Text(
                            name,
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset(Images.ic_location),
                        SizedBox(width: 6),
                        address != null ? Text(
                          address,
                          style: AppTextStyles.regularW400(context, size: 13, color: AppColors.grey2),
                        ) : Container(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 11, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    career,
                    style: AppTextStyles.regularW500(context, size: 13, color: AppColors.grey3),
                  ),
                ),
                Spacer(),
                SvgPicture.asset(Images.ic_salary),
                SizedBox(width: 8),
                Text(
                  money,
                  style: AppTextStyles.regularW400(context, size: 13, color: AppColors.grey2),
                )
              ],
            ),
            check
                ? Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Row(
                children: [
                  SizedBox(width: 5),
                  Text(
                    turnedDeal,
                    style: AppTextStyles.regularW700(context, size: 14, color: AppColors.black),
                  ),
                  Text(
                    ' lượt đặt giá',
                    style: AppTextStyles.regularW400(context, size: 14, color: AppColors.black),
                  ),
                  Spacer(),
                  Text(
                    'Hết hạn: ',
                    style: AppTextStyles.regularW700(context, size: 14, color: AppColors.black),
                  ),
                  Text(
                    dateEnd,
                    style: AppTextStyles.regularW400(context, size: 14, color: AppColors.black),
                  ),
                ],
              ),
            )
                : Container(),
            SizedBox(height: 18),
            Row(
              children: List.generate(listSkill.length, (index) {
                return CareerFreelancer(
                  name: listSkill[index],
                );
              }),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onPress,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 21, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: Center(
                          child: Text(
                            'XEM CHI TIẾT',
                            style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  DialogBid() {
    BuildContext context = Get.context;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) => Dialog(
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
            padding: EdgeInsets.symmetric(horizontal: 35),
            height: height * 0.7,
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    'ĐẶT GIÁ',
                    style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black2),
                  ),
                ),
                Divider(
                  color: AppColors.line,
                  thickness: 0.5,
                ),
                SizedBox(height: 20),
                RichText(
                    text: TextSpan(
                        text: 'Đặt giá cho công việc ',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.black, height: 1.4, wordSpacing: 1.3),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Tìm coder thiết kế website chủ yếu là Landing Page ',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.blue2, height: 1.4)),
                          TextSpan(
                            text: 'để có mức giá phù hợp với bạn nhất!',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.black, height: 1.4),
                          )
                        ])),
                SizedBox(height: 15),
                TextFieldDialog(
                  hintText: 'Nhập mức lương mong muốn',
                  textEditingController: controller.salaryWantTextEditingController,
                ),
                TextFieldDialog(
                  hintText: 'Nhập địa chỉ Email của bạn',
                  textEditingController: controller.yourEmailTextEditingController,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white3,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Đặt giá kết thúc ngày 26/9/2020',
                      style: AppTextStyles.regularW400(context, size: 14, color: AppColors.blue2),
                    )),
                SizedBox(height: 34),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.dealSalary();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Text(
                                'Đặt giá',
                                style: AppTextStyles.regularW500(context, size: 16, color: AppColors.white),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.salaryWantTextEditingController.clear();
                          controller.yourEmailTextEditingController.clear();
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.grey),
                          ),
                          child: Center(
                              child: Text(
                                'Hủy',
                                style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  DialogLogin() {
    BuildContext context = Get.context;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Dialog(
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
            padding: EdgeInsets.symmetric(horizontal: 35),
            height: height * 0.4,
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    'Thông báo',
                    style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black2),
                  ),
                ),
                Divider(
                  color: AppColors.line,
                  thickness: 0.5,
                ),
                SizedBox(height: 20),
                Text('Vui lòng đăng nhập để đặt giá cho công việc này!',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,height: 1.4),textAlign: TextAlign.center,),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Text(
                                'Đăng nhập',
                                style: AppTextStyles.regularW500(context, size: 16, color: AppColors.white),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.grey),
                          ),
                          child: Center(
                              child: Text(
                                'Hủy',
                                style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class TextFieldDialog extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final String hintText;

  const TextFieldDialog({
    Key key,
    this.hintText,
    this.textEditingController,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white, border: Border.all(color: AppColors.grey)),
      child: Center(
        child: TextField(
          onChanged: (value) {
            if (onChanged != null) onChanged(value);
          },
          controller: textEditingController,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.hintTextAB),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
