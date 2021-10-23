import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/dialog_login_watch_contact.dart';
import 'package:freelancer_app/widgets/mine_card_job_freelancer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JobPostedScreen extends StatelessWidget {
  final String urlAvatar;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String dateJoin;
  final String jobPosted;

  const JobPostedScreen({Key key, this.urlAvatar, this.name, this.address, this.phone, this.email, this.dateJoin, this.jobPosted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // var convert0 = NumberFormat('###,###,###,###,###,##0', 'en_US');
    NavigationController navigationController = Get.put(NavigationController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.whiteDot,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          'Việc làm đã đăng',
          style: AppTextStyles.regularW500(context, size: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(Images.top_watch_detail),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GetBuilder<NavigationController>(
                init: NavigationController(),
                builder: (controller) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: width,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: urlAvatar,
                                height: 83,
                                width: 83,
                                placeholder: (context, url) => SizedBox(
                                  child: CircularProgressIndicator(),
                                  width: 72,
                                  height: 72,
                                ),
                                errorWidget: (context, url, error) => SvgPicture.asset(
                                  Images.logo_user,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            name,
                            style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                          ),
                          SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images.ic_location_detail),
                              SizedBox(width: 8),
                              Text(
                                address,
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey4),
                              ),
                            ],
                          ),
                          SizedBox(height: 21),
                          Divider(
                            thickness: 0.5,
                            color: AppColors.grey,
                          ),
                          SizedBox(height: 17),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'SĐT:',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey4),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: waitLoginController.checkLogin.value ? null : () => Get.dialog(DialogLoginWatchContact()),
                                      child: Text(
                                        waitLoginController.checkLogin.value ? phone : 'Đăng nhập để xem SĐT',
                                        style: AppTextStyles.regularW400(context,
                                            size: 15, color: waitLoginController.checkLogin.value ? AppColors.black : AppColors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      'Email:',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey4),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: waitLoginController.checkLogin.value ? null : () => Get.dialog(DialogLoginWatchContact()),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Text(
                                          waitLoginController.checkLogin.value ? email : 'Đăng nhập để xem Email',
                                          style: AppTextStyles.regularW400(context,
                                              size: 15, color: waitLoginController.checkLogin.value ? AppColors.black : AppColors.orange),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      'Tham gia:',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey4),
                                    ),
                                    Spacer(),
                                    Text(
                                      dateJoin,
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      'Đã đăng:',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey4),
                                    ),
                                    Spacer(),
                                    Text(
                                      jobPosted,
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 100,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              minHeight: 100,
                            ),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.listCongViecDaDang.length,
                                itemBuilder: (context, index) {
                                  return MineCardJobFreelancer(
                                    career: controller.listCongViecDaDang[index].hinhThucCv,
                                    check: true,
                                    linkLogo: controller.listCongViecDaDang[index].anhLogoCv,
                                    urlLogo: controller.listCongViecDaDang[index].pathLogo + '/' + controller.listCongViecDaDang[index].anhLogoCv,
                                    name: controller.listCongViecDaDang[index].tenCv,
                                    address: controller.listCongViecDaDang[index].diaChiCv,
                                    money: controller.listCongViecDaDang[index].chiPhiCv,
                                    dateEnd: controller.listCongViecDaDang[index].hetHanDatGiaCv,
                                    turnedDeal: controller.listCongViecDaDang[index].luotDatGiaCv,
                                    listSkill: controller.getSkillJobPosted(index),
                                    onPress: () {
                                      controller.checkDetailJob.value = true;
                                      controller.checkDetailJobPost();
                                      controller.indexIdJob.value = controller.listCongViecDaDang[index].maCv;
                                      controller.getDetailJob();
                                    },
                                  );
                                }),
                          ),
                          SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              controller.loadMoreJobPosted();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Xem thêm',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                SizedBox(width: 5),
                                SvgPicture.asset(Images.ic_down),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
