import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_freelancer_set_latest_sprice.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/screens/latest_jobs_listing/latest_jobs_listing_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'custom_textfield_ongoing_project.dart';

class ItemListFreelancerSettingNewSprice extends StatelessWidget {
  ItemListFreelancerSettingNewSprice({Key key, this.datGia}) : super(key: key);
  final DsDatgia datGia;
  final LatestJobsListingController controller = Get.put(LatestJobsListingController());
  final NavigationController navigationController = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Tên Freelancer",
                height: height * 0.09,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        datGia.tenFreelancer,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regularW400(context,
                            size: 16, color: AppColors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      InkWell(
                        onTap: (){
                          navigationController.indexIdFreelancer.value = datGia.idFlc;
                          navigationController.detailFreelancer();
                        },
                        child: Text(
                          "(Xem chi tiết)",
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
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Tên công việc",
                height: height * 0.09,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        datGia.tenCongViec,
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
                          navigationController.indexIdJob.value = datGia.idJob;
                          navigationController.getDetailJob();
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
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Ngân sách dự kiến",
                height: height * 0.09,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      datGia.nganSachDuKien,
                      style: AppTextStyles.regularW500(
                        context,
                        size: 16,
                        color: AppColors.red,
                      ),
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
                text: "Đặt giá",
                height: height * 0.09,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        datGia.datGia,
                        style: AppTextStyles.regularW500(
                          context,
                          size: 16,
                          color: AppColors.red,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              controller.acceptOrReject(datGia,
                                  token: SpUtil.getString(ConstString.token),
                                  idDatGia: datGia.idDatGia,
                                  chapNhan: '1');
                            },
                            child: Text(
                              "Chấp nhận",
                              style: AppTextStyles.regularW400(
                                context,
                                size: 16,
                                color: AppColors.green1,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap: (){
                              controller.acceptOrReject(datGia,
                                  token: SpUtil.getString(ConstString.token),
                                  idDatGia: datGia.idDatGia,
                                  chapNhan: '2');
                            },
                            child: Text(
                              "Từ chối",
                              style: AppTextStyles.regularW400(
                                context,
                                size: 16,
                                color: AppColors.red,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
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
              InkWell(
                onTap: (){
                  UtilsData.launchTelUrl(datGia.lienHe);
                },
                child: CustomTextFieldOnGoingProject(
                  text: "Liên hệ",
                  icon: Images.ic_call,
                  height: height * 0.08,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      datGia.lienHe,
                      style: AppTextStyles.regularW500(
                        context,
                        size: 16,
                        color: AppColors.black3,
                      ),
                    ),
                  ),
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
