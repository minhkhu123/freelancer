import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_freelancer_saved.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/freelancer_saved/freelance_saved_controller.dart';
import 'package:freelancer_app/screens/authens/ongoing_project/ongoing_project_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/custom_text_field_skill.dart';
import 'package:freelancer_app/widgets/custom_textfield_ongoing_project.dart';
import 'package:freelancer_app/widgets/dialog_confirm_delete.dart';
import 'package:freelancer_app/widgets/top_employer_profile.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class FreelancerSavedScreen extends StatelessWidget {
  FreelancerSavedScreen({Key key}) : super(key: key);
  final OnGoingProjectController controller = Get.put(OnGoingProjectController());
  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<FreelancerSavedController>(
            init: FreelancerSavedController(),
            builder: (controller) => Column(
              children: [
                TopEmployerProfile(
                  onPress: () {
                    Get.back();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 15),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(width: 2, color: AppColors.blue)),
                  child: controller.listFreelancerSaved.isEmpty
                      ? Container(
                          height: height * 0.45,
                          child: Obx(() => Center(
                                child: Text(
                                  controller.messageNotificationFreelancerSave.value,
                                  style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                                ),
                              )),
                        )
                      : Column(
                          children: [
                            Container(
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 8,
                                ),
                                child: Text(
                                  "Freelancer đã lưu",
                                  style: AppTextStyles.regularW500(context, size: 18),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: List.generate(
                                    controller.listFreelancerSaved.length,
                                    (index) => _itemListFreelancerHasSetAPrice(context, height, width, controller,
                                        element: controller.listFreelancerSaved[index])),
                              ),
                            ),
                            Obx(
                              () => controller.messageNotificationFreelancerSave.value.isEmpty
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              child: Text(
                                                "Xem thêm",
                                                style: AppTextStyles.regularW700(context, size: 15, color: AppColors.orange),
                                              ),
                                              onTap: () {
                                                controller.countLoadTimeFreelancerSaved.value++;
                                                controller.getFreelancerSaved(
                                                    token: SpUtil.getString(ConstString.token),
                                                    xemThem: controller.countLoadTimeFreelancerSaved.value);
                                              },
                                            ),
                                            Container(
                                              height: 2,
                                              width: 65,
                                              color: AppColors.orange,
                                              child: Text(" "),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SvgPicture.asset(Images.ic_doubleDown)
                                      ],
                                    )
                                  : SizedBox(),
                            ),
                            SizedBox(height: 15)
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemListFreelancerHasSetAPrice(context, height, width, FreelancerSavedController ctrl, {ListFlcSaved element}) {
    final skills = controller.getSelectSkill(3, element.kyNang);

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
                        element.tenFreelancer,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      InkWell(
                        onTap: () {
                          navigationController.indexIdFreelancer.value = element.id;
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
                text: "Ngành nghề",
                height: height * 0.07,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      element.nganhNghe,
                      textAlign: TextAlign.center,
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
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldOnGoingProject(
                text: "Kỹ năng",
                height: height * 0.1,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: element.kyNang.isEmpty
                      ? Center(
                          child: Text("Không có kĩ năng nào", style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black)),
                        )
                      : Container(
                          height: height * 0.1,
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 3,
                            itemCount: skills.length,
                            itemBuilder: (context, index) {
                              if (index < controller.ind) {
                                return CustomTextFieldSkill(text: skills[index]);
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
                text: "Địa chỉ",
                height: height * 0.06,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    element.diaChi,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regularW400(
                      context,
                      size: 16,
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
                text: "Đánh giá",
                height: height * 0.07,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    RatingBar.builder(
                      itemSize: 20,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      initialRating: element.tbSaoDanhGia.toDouble(),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: AppColors.orange,
                      ),
                      onRatingUpdate: (value) {
                        print(value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Get.dialog(DialogConfirmDelete(
                onPress: () {
                  ctrl.deleteSavedFreelancer(token: SpUtil.getString(ConstString.token), idFlc: int.parse(element.id));
                  ctrl.deleteElement(element);
                  Get.back();
                },
              ));
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.orange)),
            child: Text(
              'Xóa',
              style: AppTextStyles.regularW700(context, size: 16),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
