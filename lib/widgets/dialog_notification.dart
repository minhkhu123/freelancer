import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:get/get.dart';

class DialogNotification extends StatelessWidget {
  const DialogNotification({Key key, this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
        child: Container(
      height: height * 0.4,
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
              message,
              style: AppTextStyles.regularW400(context,
                  size: 16, color: AppColors.black, lineHeight: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.04,
                width: width * 0.25,
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.orange)),
                    child: Text(
                      "Ok",
                      style: AppTextStyles.regularW700(context, size: 15),
                    )),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
