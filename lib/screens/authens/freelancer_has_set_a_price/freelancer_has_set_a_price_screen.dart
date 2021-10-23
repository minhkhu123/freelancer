import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_freelancer_has_set_a_price.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/screens/authens/freelancer_has_set_a_price/freelancer_has_set_a_price_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/custom_textfield_ongoing_project.dart';
import 'package:freelancer_app/widgets/top_employer_profile.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class FreelancerHasSetAPriceScreen extends StatelessWidget {
  FreelancerHasSetAPriceScreen({Key key}) : super(key: key);
  final NavigationController navigationController = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<FreelancerHasSetAPriceController>(
          init: FreelancerHasSetAPriceController(),
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                TopEmployerProfile(
                  onPress: () {
                    Get.back();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16,bottom: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: AppColors.blue)),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          child: Text(
                            "Freelancer đã đặt giá",
                            style: AppTextStyles.regularW500(context, size: 19),
                          ),
                        ),
                      ),
                      controller.listDSDatGia.isEmpty
                          ? Obx(() => Container(
                                height: height * 0.45,
                                child: Center(
                                  child: Text(
                                    controller.messageError.value,
                                    style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                                  ),
                                ),
                              ))
                          : Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    children: List.generate(controller.listDSDatGia.length,
                                        (index) => _itemListFreelancerHasSetAPrice(context, height, width, controller.listDSDatGia[index])),
                                  ),
                                ),
                                Obx(
                                  () => controller.messageError.value.isEmpty
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.countLoadTime.value++;
                                                    controller.getDsDatGia(
                                                        token: SpUtil.getString(ConstString.token), xemThem: controller.countLoadTime.value);
                                                  },
                                                  child: Text(
                                                    "Xem thêm",
                                                    style: AppTextStyles.regularW700(context, size: 15, color: AppColors.orange),
                                                  ),
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
                              ],
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

  Widget _itemListFreelancerHasSetAPrice(context, height, width, DsDatgia datgia) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 8),
      child: GetBuilder<FreelancerHasSetAPriceController>(
        init: FreelancerHasSetAPriceController(),
        builder: (controller) => Column(
          children: [
            Row(
              children: [
                CustomTextFieldOnGoingProject(
                  text: "Tên Freelancer",
                  height: height * 0.08,
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
                          datgia.tenFreelancer,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        InkWell(
                          onTap: (){
                            navigationController.indexIdFreelancer.value = datgia.idFlc;
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
                  height: height * 0.08,
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
                          datgia.tenCongViec,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        InkWell(
                          onTap: (){
                            navigationController.indexIdJob.value = datgia.maViec;
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
                  height: height * 0.08,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Text(
                        datgia.nganSachDuKien,
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
                          datgia.datGia,
                          style: AppTextStyles.regularW500(
                            context,
                            size: 16,
                            color: AppColors.red,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.acceptOrReject(datgia,
                                    token: SpUtil.getString(ConstString.token), idDatGia: datgia.idDatGia, chapNhan: '1');
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
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                controller.acceptOrReject(datgia,
                                    token: SpUtil.getString(ConstString.token), idDatGia: datgia.idDatGia, chapNhan: '2');
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
                  onTap: () {
                    UtilsData.launchTelUrl(datgia.lienHe);
                  },
                  child: CustomTextFieldOnGoingProject(
                    text: "Liên hệ",
                    icon: Images.ic_call,
                    height: height * 0.07,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        datgia.lienHe,
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
      ),
    );
  }
}
