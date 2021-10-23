import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_ntd.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_dimens.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/chat/chat_not_use.dart';
import 'package:freelancer_app/screens/home/search_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/dialog_bid_ntd.dart';
import 'package:freelancer_app/widgets/dialog_login_ntd.dart';
import 'package:freelancer_app/widgets/dialog_minus_point_contact.dart';
import 'package:get/get.dart';

import 'career_freelancer.dart';

class CardJobNTD extends StatelessWidget {
  final String career;
  final bool check;
  final VoidCallback onPress;
  final bool checkButton;
  final String name;
  final String job;
  final String urlImage;
  final String address;
  final double rateStar;
  final String exp;
  final String phoneCall;
  final List<String> listSkill;
  final List<String> listCareer;
  final bool viewed;
  final String userId;

  const CardJobNTD(
      {Key key,
      this.listSkill,
      this.listCareer,
      this.career,
      this.check,
      this.onPress,
      this.checkButton,
      this.name,
      this.address,
      this.urlImage,
      this.job,
      this.rateStar,
      this.exp,
      this.viewed,
        this.userId,
      this.phoneCall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: onPress,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(AppDimens.padding4, AppDimens.padding4, AppDimens.padding4, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: urlImage,
                          height: 83,
                          width: 83,
                          placeholder: (context, url) => SizedBox(
                            child: CircularProgressIndicator(),
                            width: 83,
                            height: 83,
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            backgroundColor: AppColors.grey6,
                            child: SvgPicture.asset(
                              Images.logo_user,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  check
                      ? Container(
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
                        )
                      : Container(),
                ],
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.54,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: onPress,
                          child: Container(
                              width: width * 0.47,
                              child: Text(
                                name,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                        Spacer(),
                        InkWell(onTap: () => navigationController.changePageOut(ChatNotUse()), child: SvgPicture.asset(Images.ic_chat)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: rateStar,
                    itemSize: 20,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    unratedColor: AppColors.grey,
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: width * 0.5,
                    child: Text(
                      job,
                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.blue),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(Images.ic_location_ntd),
                      SizedBox(width: 9),
                      Text(
                        address,
                        style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey2),
                      )
                    ],
                  ),
                  check
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Text(
                                'Kinh nghiệm: ',
                                style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey2),
                              ),
                              Container(
                                width: width * 0.25,
                                child: Text(
                                  exp,
                                  style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey2),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: List.generate(listSkill.length, (index) {
                if (index < navigationController.ind.value) {
                  return CareerFreelancer(
                    name: listSkill[index],
                  );
                } else if (index == navigationController.ind.value) {
                  return Container(
                    height: 25,
                    width: 50,
                    decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(
                        "+${listSkill.length - navigationController.ind.value}",
                        style: AppTextStyles.regularW400(context, size: 14, color: AppColors.white),
                      ),
                    ),
                  );
                }
                return SizedBox();
              }),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: checkButton
                ? Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          waitLoginController.checkLogin.value
                              ? Get.dialog(DialogBidNTD(
                                  onPressCall: viewed ? () {
                                    navigationController.launchTelURL(phoneCall);
                                  } : () async {
                                    navigationController.indexIdFreelancer.value = userId;
                                    Get.back();
                                    EmployerInfor employerInfor = await UtilsData.employerInfor();
                                    Get.dialog(DialogMinusPointContact(
                                      employerInfor: employerInfor,
                                      phoneCall: phoneCall,
                                    ));
                                  },
                                ))
                              : Get.dialog(DialogLoginNTD());
                        },
                        child: Container(
                          height: 35,
                          width: width * 0.37,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                              child: Text(
                            'LIÊN HỆ',
                            style: AppTextStyles.regularW500(context, size: 16, color: AppColors.white),
                          )),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: onPress,
                        child: Container(
                          height: 35,
                          width: width * 0.37,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(7),
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
                  )
                : Container(),
          )
        ],
      ),
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
