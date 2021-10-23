import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:get/get.dart';

class DialogMinusPoint extends StatelessWidget {
  const DialogMinusPoint({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Container(
        height: 276,
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
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Bạn có",
                    style: AppTextStyles.regularW500(context,
                        size: 16, color: AppColors.black),
                  ),
                  TextSpan(
                    text: " 10 ",
                    style: AppTextStyles.regularW500(context,
                        size: 16, color: AppColors.orange),
                  ),
                  TextSpan(
                    text: "điểm hôm nay. Bạn có muốn dừng",
                    style: AppTextStyles.regularW500(context,
                        size: 16, color: AppColors.black),
                  ),
                  TextSpan(
                    text: " 1 điểm ",
                    style: AppTextStyles.regularW500(context,
                        size: 16, color: AppColors.red),
                  ),
                  TextSpan(
                    text: "để xem số điện thoại Freelancer này không?",
                    style: AppTextStyles.regularW500(context,
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
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.orange)),
                      child: Text(
                        "Đồng ý",
                        style: AppTextStyles.regularW700(context, size: 15),
                      )),
                ),
                SizedBox(
                  width: 5,
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
