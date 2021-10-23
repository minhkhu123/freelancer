import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_dimens.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';

import 'career_freelancer.dart';

class CardJobFreelancer extends StatelessWidget {
  final String career;
  final bool check;
  final VoidCallback onPress;
  final VoidCallback onTapDeal;
  final String urlImage;
  final String title;
  final String address;
  final String money;
  final String tag;
  final int index;
  final int turned;
  final String dateClose;
  final List<String> listSkill;

  const CardJobFreelancer(
      {Key key,
      this.career,
      this.check,
      this.onPress,
      this.title,
      this.urlImage,
      this.address,
      this.money,
      this.tag,
      this.index,
      this.turned,
      this.dateClose,
      this.onTapDeal,
      this.listSkill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
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
                  child: Container(
                    padding: EdgeInsets.fromLTRB(AppDimens.padding4, AppDimens.padding4, AppDimens.padding4, 0),
                    child: CachedNetworkImage(
                      imageUrl: urlImage,
                      height: 67,
                      width: 67,
                      placeholder: (context, url) => SizedBox(
                        child: CircularProgressIndicator(),
                        width: 67,
                        height: 67,
                      ),
                      errorWidget: (context, url, error) => SvgPicture.asset(Images.logo_freelancer),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: onPress,
                      child: Container(
                          width: width * 0.58,
                          child: Text(
                            title,
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
                        Text(
                          '$address',
                          style: AppTextStyles.regularW400(context, size: 13, color: AppColors.grey2),
                        ),
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
                  '$moneyđ',
                  style: AppTextStyles.regularW400(context, size: 13, color: AppColors.grey2),
                ),
                SizedBox(width: 8),
              ],
            ),
            check
                ? Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Text(
                          '$turned',
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
                          dateClose,
                          style: AppTextStyles.regularW400(context, size: 14, color: AppColors.black),
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(height: 18),
            Row(
              children: List.generate(listSkill.length, (index) {
                // if (index < navigationController.ind.value) {
                  return CareerFreelancer(
                    name: listSkill[index],
                  );
                // } else if (index == navigationController.ind.value) {
                //   return Container(
                //     height: 20,
                //     width: 50,
                //     margin: const EdgeInsets.only(top: 5),
                //     decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(100)),
                //     child: Center(
                //       child: Text(
                //         "+${listSkill.length - navigationController.ind.value}",
                //         style: AppTextStyles.regularW400(context, size: 14, color: AppColors.white),
                //       ),
                //     ),
                //   );
                // }
                // return SizedBox();
              }),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: onTapDeal,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text(
                        'ĐẶT GIÁ',
                        style: AppTextStyles.regularW500(context, size: 16, color: AppColors.white),
                      )),
                    ),
                  ),
                  Spacer(),
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
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldDialog extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType keyboardType;
  final String error;
  final List<TextInputFormatter> inputFormatters;

  const TextFieldDialog({
    Key key,
    this.hintText,
    this.textEditingController,
    this.keyboardType,
    this.error,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: TextFormField(
          onChanged: (value) {
            if (onChanged != null) onChanged(value);
          },
          controller: textEditingController,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            fillColor: Colors.white,
            // filled: true,
            hintText: hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.hintTextAB),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: AppColors.greyBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: AppColors.greyBorder),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyBorder),
              borderRadius: BorderRadius.circular(30),
            ),
            isDense: true,
            errorText: error,
          ),
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }
}
