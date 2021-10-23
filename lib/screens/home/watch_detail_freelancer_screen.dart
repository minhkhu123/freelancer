import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_ntd.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/chat/chat_not_use.dart';
import 'package:freelancer_app/screens/menu/list_freelancer.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/career_freelancer.dart';
import 'package:freelancer_app/widgets/dialog_login_ntd.dart';
import 'package:freelancer_app/widgets/dialog_login_save_freelancer.dart';
import 'package:freelancer_app/widgets/dialog_login_watch_contact.dart';
import 'package:freelancer_app/widgets/dialog_login_watch_contact_freelancer.dart';
import 'package:freelancer_app/widgets/dialog_minus_point_contact.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class WatchDetailFreelancerScreen extends StatelessWidget {
  final String name;
  final String urlAvatar;
  final String job;
  final String address;
  final double rate;
  final bool saveFreelancer;
  final double percentComplete;
  final String classification;
  final String sex;
  final String phone;
  final String email;
  final String birth;
  final String exp;
  final String intro;
  final List<String> listSkill;

  const WatchDetailFreelancerScreen(
      {Key key,
      this.listSkill,
      this.name,
      this.urlAvatar,
      this.job,
      this.saveFreelancer,
      this.address,
      this.rate,
      this.percentComplete,
      this.classification,
      this.sex,
      this.phone,
      this.email,
      this.birth,
      this.exp,
      this.intro})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    NavigationController navigationController = Get.put(NavigationController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.whiteDot,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                navigationController.clearListDetailFreelancer();
                Get.back();
              },
            ),
            title: Text(
              'Danh sách.../ $name',
              style: AppTextStyles.regularW500(context, size: 18),
            ),
          ),
          body: SingleChildScrollView(
            child: GetBuilder<NavigationController>(
              init: NavigationController(),
              builder: (controller) => Column(
                children: [
                  SizedBox(
                    height: 190,
                    child: Stack(
                      children: [
                        Image.asset(Images.top_bg_detail_freelancer),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: urlAvatar,
                                  height: 80,
                                  width: 80,
                                  placeholder: (context, url) => SizedBox(
                                    child: CircularProgressIndicator(),
                                    width: 80,
                                    height: 80,
                                  ),
                                  errorWidget: (context, url, error) => SvgPicture.asset(Images.logo_user),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: AppTextStyles.regularW500(context, size: 18),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: width * 0.5,
                                    child: Text(
                                      job,
                                      style: AppTextStyles.regularW400(context, size: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        Images.ic_location_ntd,
                                        color: AppColors.white,
                                      ),
                                      SizedBox(width: 9),
                                      Container(
                                        width: width * 0.5,
                                        child: Text(
                                          address,
                                          style: AppTextStyles.regularW400(context, size: 14),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: 120,
                            left: 30,
                            right: 30,
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                            ))
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.9,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 35),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.orange2,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$rate',
                            style: AppTextStyles.regularW700(context, size: 26),
                          ),
                        ),
                        SizedBox(height: 13),
                        Text(
                          classification,
                          style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                        ),
                        SizedBox(height: 12),
                        RatingBar.builder(
                          initialRating: rate,
                          ignoreGestures: true,
                          itemSize: 50,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
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
                        SizedBox(height: 27),
                        CircularPercentIndicator(
                          radius: width * 0.4,
                          lineWidth: 15,
                          percent: percentComplete,
                          backgroundColor: AppColors.percentNot,
                          circularStrokeCap: CircularStrokeCap.butt,
                          progressColor: AppColors.blue2,
                          center: Text(
                            '${percentComplete * 100}%',
                            style: AppTextStyles.regularW700(context, size: 26, color: AppColors.blue),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Hoàn thành công việc',
                          style: AppTextStyles.regularW500(context, size: 17, color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: width * 0.9,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.white),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19),
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 28,
                                      width: 5,
                                      decoration: BoxDecoration(
                                        color: AppColors.orange,
                                      ),
                                    ),
                                    SizedBox(width: 14),
                                    Text(
                                      'Thông tin liên hệ',
                                      style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ),
                              ProfileContact(
                                title: 'Họ và tên',
                                subtitle: name,
                              ),
                              ProfileContact(
                                title: 'Giới tính',
                                subtitle: sex,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'SĐT: ',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey3),
                                    ),
                                    InkWell(
                                      onTap: waitLoginController.checkLogin.value ? controller.viewedFreelancer.value
                                          ? null
                                          : () async {
                                        EmployerInfor employerInfor = await UtilsData.employerInfor();
                                        Get.dialog(DialogMinusPointContact(
                                          employerInfor: employerInfor,
                                          phoneCall: controller.resultDetailFreelancer.data.freelancerInfor.sdt,
                                        ));
                                      } : () => Get.dialog(DialogLoginWatchContactFreelancer()),
                                      child: Text(
                                        controller.viewedFreelancer.value ? phone : 'Dùng điểm để xem',
                                        style: AppTextStyles.regularW700(context,
                                            size: 15, color: controller.viewedFreelancer.value ? AppColors.grey3 : AppColors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Email: ',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey3),
                                    ),
                                    InkWell(
                                      onTap: waitLoginController.checkLogin.value ? controller.viewedFreelancer.value
                                          ? null
                                          : () async {
                                        EmployerInfor employerInfor = await UtilsData.employerInfor();
                                        Get.dialog(DialogMinusPointContact(
                                          employerInfor: employerInfor,
                                          phoneCall: controller.resultDetailFreelancer.data.freelancerInfor.sdt,
                                        ));
                                      } : () => Get.dialog(DialogLoginWatchContactFreelancer()),
                                      child: Text(
                                        controller.viewedFreelancer.value ? email : 'Dùng điểm để xem',
                                        style: AppTextStyles.regularW700(context,
                                            size: 15, color: controller.viewedFreelancer.value ? AppColors.grey3 : AppColors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ProfileContact(
                                title: 'Sinh ngày',
                                subtitle: birth,
                              ),
                              ProfileContact(
                                title: 'Địa chỉ',
                                subtitle: address,
                              ),
                              ProfileContact(
                                title: 'Ngành nghề',
                                subtitle: job,
                              ),
                              ProfileContact(
                                title: 'Kinh nghiệm',
                                subtitle: '$exp năm',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  waitLoginController.checkLogin.value ? controller.savedFreelancer() : Get.dialog(DialogLoginSaveFreelancer());
                                },
                                child: Container(
                                  height: 45,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                      color: controller.saveFreelancer.value ? AppColors.orange : AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: controller.saveFreelancer.value ? AppColors.orange : AppColors.grey)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Images.ic_star,
                                        color: controller.saveFreelancer.value ? AppColors.white : AppColors.blue,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Lưu Freelancer',
                                        style: AppTextStyles.regularW500(context,
                                            size: 15, color: controller.saveFreelancer.value ? AppColors.white : AppColors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: waitLoginController.checkLogin.value
                                    ? controller.viewedFreelancer.value
                                        ? () => controller.launchTelURL(controller.resultDetailFreelancer.data.freelancerInfor.sdt)
                                        : () async {
                                            EmployerInfor employerInfor = await UtilsData.employerInfor();
                                            Get.dialog(DialogMinusPointContact(
                                              employerInfor: employerInfor,
                                              phoneCall: controller.resultDetailFreelancer.data.freelancerInfor.sdt,
                                            ));
                                          }
                                    : () => Get.dialog(DialogLoginNTD()),
                                child: Container(
                                  height: 45,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: AppColors.blue,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Liên hệ',
                                        style: AppTextStyles.regularW500(context, size: 16, color: AppColors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.9,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Container(
                                height: 28,
                                width: 5,
                                decoration: BoxDecoration(
                                  color: AppColors.orange,
                                ),
                              ),
                              SizedBox(width: 14),
                              Text(
                                'Giới thiệu bản thân',
                                style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          intro,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.black, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.9,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 28,
                              width: 5,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                              ),
                            ),
                            SizedBox(width: 14),
                            Text(
                              'Hồ sơ năng lực',
                              style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                            ),
                          ],
                        ),
                        Container(
                          constraints: BoxConstraints(minHeight: 100),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.listProjectFile.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  height: height * 0.3,
                                  width: width * 0.9,
                                  child: PageView.builder(
                                      controller: PageController(viewportFraction: 0.75, initialPage: 0),
                                      itemCount: controller.listProjectImage.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: CachedNetworkImage(
                                              imageUrl: controller.listProjectImage[index].pathProfileImg,
                                              height: 83,
                                              width: 83,
                                              placeholder: (context, url) => SizedBox(
                                                child: CircularProgressIndicator(),
                                                width: 72,
                                                height: 72,
                                              ),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Text(controller.listProjectFile[index].nameProject,
                                    style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black), textAlign: TextAlign.center),
                                SizedBox(height: 10),
                                Text(controller.listProjectFile[index].nameFile,
                                    style: AppTextStyles.regularW400(context, size: 16, color: AppColors.blue2), textAlign: TextAlign.center),
                                SizedBox(height: 15),
                                InkWell(
                                  onTap: () => _launchURL(controller.listProjectFile[index].pathFile),
                                  child: Container(
                                    height: height * 0.06,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.blue),
                                    child: Center(
                                        child: Text(
                                      'Tải xuống',
                                      style: AppTextStyles.regularW700(context, size: 16, color: AppColors.white),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.9,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.white),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                            color: AppColors.blue,
                          ),
                          child: Center(
                              child: Text(
                            'Top Freelancer nổi bật',
                            style: AppTextStyles.regularW700(context, size: 18),
                          )),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: 100
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.listTopFlc.length,
                            itemBuilder: (context, index) => TopFreelancer(
                              urlAva: controller.listTopFlc[index].pathAvtFlcTop + controller.listTopFlc[index].anhAvt,
                              name: controller.listTopFlc[index].nameFlc,
                              job: controller.listTopFlc[index].ngheNghiep,
                              city: controller.listTopFlc[index].tinhThanh,
                              rateTB: double.parse(controller.listTopFlc[index].rateStar.toString()),
                              listSkill: controller.getSkillTopFreelancerDetailFreelancer(index, 3),
                              onPress: () {
                                controller.checkTopFlc = controller.listTopFlc[index].idFlc;
                                controller.showTopFlc(index);
                                controller.update();
                              },
                              showDetail: () {
                                controller.indexIdFreelancer.value = controller.listTopFlc[index].idFlc;
                                Get.back();
                                controller.listTopFlc.clear();
                                controller.detailFreelancer();
                              },
                              index: index,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            navigationController.resetFilter();
                            navigationController.clearListSearch();
                            navigationController.getListFreelancer();
                            Get.to(ListFreelancerScreen());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 28),
                            height: height * 0.06,
                            width: width * 0.54,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.orange),
                            child: Center(
                                child: Text(
                              'Xem tất cả Freelancer',
                              style: AppTextStyles.regularW700(context, size: 16, color: AppColors.white),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class TopFreelancer extends StatelessWidget {
  const TopFreelancer({
    Key key,
    this.name,
    this.city,
    this.job,
    this.rateTB,
    this.onPress,
    this.urlAva,
    this.listSkill,
    this.showDetail,
    this.index,
  }) : super(key: key);

  final String name;
  final String city;
  final String job;
  final double rateTB;
  final VoidCallback onPress;
  final VoidCallback showDetail;
  final String urlAva;
  final List<String> listSkill;
  final int index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                InkWell(
                  onTap: showDetail,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: urlAva,
                      height: 58,
                      width: 58,
                      placeholder: (context, url) => SizedBox(
                        child: CircularProgressIndicator(),
                        width: 58,
                        height: 58,
                      ),
                      errorWidget: (context, url, error) => SvgPicture.asset(Images.logo_user),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: showDetail,
                      child: Text(
                        name,
                        style: AppTextStyles.regularW500(context, size: 17, color: AppColors.black),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: width * 0.35,
                          child: Text(
                            job,
                            style: AppTextStyles.regularW400(context, size: 15, color: AppColors.blue2),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                            onTap: () => controller.changePageOut(ChatNotUse()),
                            child: SvgPicture.asset(Images.ic_chat)),
                      ],
                    )
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: controller.listTopFlc[index].idFlc == controller.checkTopFlc && controller.topFlc.value ? Icon(Icons.arrow_drop_up) : Icon(Icons.arrow_drop_down),
                  onPressed: onPress,
                )
              ],
            ),
          ),
          controller.listTopFlc[index].idFlc == controller.checkTopFlc && controller.topFlc.value
              ? Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Images.ic_location_ntd,
                          color: AppColors.green,
                        ),
                        SizedBox(width: 9),
                        Text(
                          city,
                          style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey),
                        ),
                        Spacer(),
                        RatingBar.builder(
                          initialRating: rateTB,
                          ignoreGestures: true,
                          itemSize: 20,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
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
                      ],
                    ),
                    SizedBox(height: 28),
                    Row(
                      children: List.generate(listSkill.length, (index) {
                        if (index < controller.ind.value) {
                          return CareerFreelancer(
                            name: listSkill[index],
                          );
                        } else if (index == controller.ind.value) {
                          return Container(
                            height: 20,
                            width: 50,
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: Text(
                                "+${listSkill.length - controller.ind.value}",
                                style: AppTextStyles.regularW400(context, size: 14, color: AppColors.white),
                              ),
                            ),
                          );
                        }
                        return SizedBox();
                      }),
                    ),
                    SizedBox(height: 20),
                    Divider(
                      color: AppColors.greyDivider,
                      thickness: 1,
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class ProfileContact extends StatelessWidget {
  const ProfileContact({Key key, this.title, this.subtitle}) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey3),
          ),
          Container(
            width: width * 0.5,
            child: Text(
              subtitle,
              style: AppTextStyles.regularW700(context, size: 15, color: AppColors.grey3),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

_launchURL(url) async {
  await launch(url);
}
