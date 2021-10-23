import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_project_freelancer_save.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/ongoing_project/ongoing_project_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/custom_text_field_skill.dart';
import 'package:freelancer_app/widgets/dialog_bid.dart';
import 'package:freelancer_app/widgets/dialog_confirm_delete_project.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'custom_textfield_ongoing_project.dart';

class ItemListSaveProject extends StatelessWidget {
  final ListProjectSaved result;

  ItemListSaveProject({this.result});

  OnGoingProjectController onGoingProjectController = Get.put(OnGoingProjectController());
  NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final skills = onGoingProjectController.getSkill(result.kyNang);

    return GetBuilder<OnGoingProjectController>(
      init: OnGoingProjectController(),
      builder: (controller) => Container(
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
                          result.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        InkWell(
                          onTap: () {
                            navigationController.indexIdJob.value = result.idProject;
                            navigationController.getDetailJob();
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
                  text: "Ngân sách dự kiến",
                  height: height * 0.08,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            result.kinhPhiDuKien,
                            style: AppTextStyles.regularW500(
                              context,
                              size: 16,
                              color: AppColors.red,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: width * 0.25,
                          height: height * 0.04,
                          child: ElevatedButton(
                              onPressed: () {
                                navigationController.indexIdJob.value = result.idProject;
                                Get.dialog(DialogBid(
                                  name: result.name,
                                  dateEnd: result.ngayDatGiaKetThuc,
                                ));
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(AppColors.blue3),
                              ),
                              child: Text(
                                "Đặt giá",
                                style: AppTextStyles.regularW500(context, size: 15, color: AppColors.blue),
                              )),
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
                CustomTextFieldOnGoingProject(
                  text: "Kỹ năng",
                  height: height * 0.1,
                ),
                // if (result.kyNang.length == 1) ...[
                //   Spacer(),
                //   result.kyNang.isEmpty
                //       ? CustomTextFieldSkill(text: skills[0])
                //       : Center(
                //           child: Text("Không có kĩ năng nào", style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black)),
                //         ),
                //   Spacer()
                // ] else
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: result.kyNang == '0'
                        ? Center(
                            child: Text("Không có kĩ năng nào", style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black)),
                          )
                        : result.kyNang.split(',').length == 1
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: CustomTextFieldSkill(text: skills),
                              ))
                            : Container(
                                height: height * 0.1,
                                child: StaggeredGridView.countBuilder(
                                  crossAxisCount: 3,
                                  itemCount: skills.length,
                                  itemBuilder: (context, index) {
                                    if (index < controller.ind) {
                                      return CustomTextFieldSkill(text: skills);
                                    } else if (index == controller.ind) {
                                      return Container(
                                        height: 20,
                                        margin: const EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(100)),
                                        child: Center(
                                          child: Text(
                                            "+${skills.length - controller.ind}",
                                            style: AppTextStyles.regularW400(context, size: 14, color: AppColors.white),
                                          ),
                                        ),
                                      );
                                    }
                                    return SizedBox();
                                  },
                                  staggeredTileBuilder: (index) => StaggeredTile.fit(skills[index].length >= 7 ? 2 : 1),
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 8,
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
                  height: height * 0.07,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Text(
                        result.ngayHetHan,
                        style: AppTextStyles.regularW400(
                          context,
                          size: 16,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: height * 0.05,
              width: width * 0.30,
              child: ElevatedButton(
                onPressed: () {
                  Get.dialog(DialogConfirmDeleteProject(
                    onPress: () => controller.deleteProjectSave(token: SpUtil.getString(ConstString.token), idProject: int.parse(result.idProject)),
                  ));
                },
                style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Xóa",
                      style: AppTextStyles.regularW700(context, size: 16),
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset(Images.ic_trash)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
