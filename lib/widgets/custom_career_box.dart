import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:get/get.dart';

class CustomCareerBox extends StatelessWidget {
  final String name;
  final bool check;
  final int index;

  CustomCareerBox({Key key, this.name, this.check, this.index});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) => InkWell(
        onTap: () {
          controller.change(index);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          height: height * 0.06,
          width: width * 0.9,
          decoration: BoxDecoration(
            color: controller.listCheckCategory[index] ? AppColors.blue1 : AppColors.white,
            border: Border.all(color: controller.listCheckCategory[index] ? AppColors.blue2 : AppColors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: controller.listCheckCategory[index] ? SvgPicture.asset(Images.ic_correct) : SvgPicture.asset(Images.ic_uncorrect),
              ),
              Container(
                width: width * 0.65,
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: controller.listCheckCategory[index] ? FontWeight.w500 : FontWeight.w400,
                      color: controller.listCheckCategory[index] ? AppColors.blue2 : AppColors.black),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
