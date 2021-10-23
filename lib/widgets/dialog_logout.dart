
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:get/get.dart';

class DialogLogOut extends StatelessWidget {
  const DialogLogOut({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Container(
        height: 268,
        width: width,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Thông báo",
              style: AppTextStyles.regularW500(context,
                  size: 20, color: AppColors.black),
            ),
            SizedBox(height: 20),
            SvgPicture.asset(Images.waring),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Text(
                "Bạn chắc chắn muốn đăng xuất khỏi hệ thống?",
                style: AppTextStyles.regularW400(context,
                    size: 16, color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.04,
                  width: width * 0.2,
                  child: ElevatedButton(
                      onPressed: Utils.logout,
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(AppColors.orange)),
                      child: Text(
                        "Ok",
                        style: AppTextStyles.regularW700(context, size: 15),
                      )),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                      height: height * 0.04,
                      width: width * 0.2,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.blue),
                          borderRadius: BorderRadius.circular(3)),
                      child: Center(
                        child: Text(
                          "Hủy",
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
