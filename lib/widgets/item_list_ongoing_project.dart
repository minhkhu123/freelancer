import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_project_freelancer_is_doing.dart';
import 'package:freelancer_app/screens/authens/ongoing_project/ongoing_project_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import '../common/theme/app_color.dart';
import '../common/theme/app_text_style.dart';
import 'custom_textfield_ongoing_project.dart';

class ItemListOnGoingProject extends StatelessWidget {
  final ListJob itemListJob;
  final OnGoingProjectController onGoingProjectController;
  final int index;

  ItemListOnGoingProject({this.itemListJob, this.onGoingProjectController, this.index});

  NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 1, right: 1),
      child: Column(
        children: [
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Tên dự án",
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
                        itemListJob.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      InkWell(
                        onTap: () {
                          controller.indexIdJob.value = itemListJob.id;
                          controller.getDetailJob();
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
                text: "Ngân sách",
                height: height * 0.07,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      itemListJob.kinhPhi,
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
                text: "Ngày hết hạn",
                height: height * 0.06,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    itemListJob.ngayHetHan,
                    style: AppTextStyles.regularW400(
                      context,
                      size: 18,
                      color: AppColors.black,
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
                text: "Trạng thái",
                height: height * 0.08,
              ),
              Expanded(
                child: Obx(() => Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: DropdownButton(
                          value: (onGoingProjectController.idStatus[index].isEmpty)
                              ? onGoingProjectController.getStatus(itemListJob.trangThai)
                              : onGoingProjectController.getStatus(onGoingProjectController.idStatus[index]),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          onChanged: (value) {
                            onGoingProjectController.onChangeStatus(value, index);
                            onGoingProjectController.updateStatus(
                                token: SpUtil.getString(ConstString.token),
                                idDatGia: itemListJob.id,
                                trangThai: onGoingProjectController.trangThai.indexOf(value).toString());
                          },
                          items: onGoingProjectController.trangThai
                              .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                      width: 130,
                                      child: Text(
                                        e,
                                        textAlign: TextAlign.center,
                                      ))))
                              .toList(),
                        ),
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CustomTextFieldOnGoingProject(
                text: "Đánh giá",
                height: height * 0.08,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: itemListJob.danhGia.toDouble(),
                      itemSize: 20,
                      minRating: 0,
                      glow: true,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      // ignoreGestures: true,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      unratedColor: AppColors.grey,
                      onRatingUpdate: (value) {
                        onGoingProjectController.onChangeStatusRate(value, index);
                        onGoingProjectController.freelancerRattingStar(
                            token: SpUtil.getString(ConstString.token),
                            rateStar: value.toInt(),
                            maViecLam: int.parse(itemListJob.id),
                            trangThai: (onGoingProjectController.idStatus[index].isEmpty)
                                ? int.parse(itemListJob.trangThai)
                                : int.parse(onGoingProjectController.idStatus[index]));
                      },
                    ),
                    Obx(() => Text(
                          '(${onGoingProjectController.danhGia[onGoingProjectController.idStatusRate[index] == 10 ? itemListJob.danhGia.toDouble() : onGoingProjectController.idStatusRate[index]]})',
                          style: AppTextStyles.regularW400(
                            context,
                            size: 13,
                            color: AppColors.grey,
                          ),
                        ))
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
