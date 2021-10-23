import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_ntd.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';

class DialogMinusPointContact extends StatelessWidget {
  const DialogMinusPointContact({Key key, this.employerInfor, this.phoneCall}) : super(key: key);
  final EmployerInfor employerInfor;
  final String phoneCall;
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Container(
        height: 276,
        width: width,
        child: Column(
          children: [
            SizedBox(height: 13),
            Text(
              "Thông báo",
              style: AppTextStyles.regularW500(context,
                  size: 20, color: AppColors.black),
            ),
            SizedBox(height: 20),
            SvgPicture.asset(Images.waring),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Bạn có ",
                    style: AppTextStyles.regularW400(context,
                        size: 16, color: AppColors.black),
                  ),
                  TextSpan(
                    text: employerInfor.diem.toString(),
                    style: AppTextStyles.regularW500(context,
                        size: 16, color: AppColors.orange),
                  ),
                  TextSpan(
                    text: " điểm hôm nay. Bạn có muốn dùng",
                    style: AppTextStyles.regularW400(context,
                        size: 16, color: AppColors.black),
                  ),
                  TextSpan(
                    text: " 1 điểm ",
                    style: AppTextStyles.regularW500(context,
                        size: 16, color: AppColors.red),
                  ),
                  TextSpan(
                    text: "để xem số điện thoại, email và liên hệ với Freelancer này không?",
                    style: AppTextStyles.regularW400(context,
                        size: 16, color: AppColors.black),
                  ),
                ]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 29,
                  width: 90,
                  child: ElevatedButton(
                      onPressed: () {
                        navigationController.minusPointContact();
                        navigationController.launchTelURL(phoneCall);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(AppColors.blue)),
                      child: Text(
                        "Đồng ý",
                        style: AppTextStyles.regularW700(context, size: 15),
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      height: 29,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.blue),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Hủy bỏ",
                          style: AppTextStyles.regularW700(context,
                              size: 15, color: AppColors.blue),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
