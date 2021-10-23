import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_posted_new.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/screens/authens/freelancer_recruitment/freelancer_recruitment_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'custom_textfield_ongoing_project.dart';

class ItemListMessagePosted extends StatelessWidget {
  ItemListMessagePosted({Key key, this.postedNew}) : super(key: key);
  final PostedNew postedNew;
  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Tên công việc",
                height: height * 0.09,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      postedNew.tenCongViec,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.regularW400(context,
                          size: 16, color: AppColors.black),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: (){
                        controller.indexIdJob.value = postedNew.id;
                        controller.getDetailJob();
                      },
                      child: Text(
                        "(Xem chi tiết công việc)",
                        style: AppTextStyles.regularW400(
                          context,
                          size: 13,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Hình thức",
                height: height * 0.06,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    UtilsData.getNameFormat(postedNew.hinhThuc),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regularW500(
                      context,
                      size: 16,
                      color: AppColors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Hạn cuối đặt giá",
                height: height * 0.08,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      postedNew.hanCuoiDatGia,
                      style: AppTextStyles.regularW400(context,
                          size: 16, color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Trạng thái",
                height: height * 0.05,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    postedNew.trangThai,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regularW400(
                      context,
                      size: 16,
                      color: AppColors.green1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Quản lý",
                height: height * 0.07,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: SvgPicture.asset(Images.progess),
                        onPressed: () {
                          UtilsData.renew(token: SpUtil.getString(ConstString.token), idViecLam: postedNew.id);
                        }),
                    IconButton(
                        icon: SvgPicture.asset(Images.ic_update),
                        onPressed: () async{
                          int id = int.parse(postedNew.id);
                          if(postedNew.hinhThuc == '1'){
                            Get.to(FreelancerRecruitmentScreen(isWork: 1, dataPost: await UtilsData.getDataPost(Address.GET_DATA_SUA_VIEC_THEO_DU_AN, token: SpUtil.getString(ConstString.token), maViecLam: id),));
                          }else if(postedNew.hinhThuc == '2'){
                            Get.to(FreelancerRecruitmentScreen(isWork: 2, dataPost: await UtilsData.getDataPost(Address.GET_DATA_SUA_VIEC_BAN_THOI_GIAN, token: SpUtil.getString(ConstString.token), maViecLam: id),));
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
        ],
      ),
    );
  }
}
