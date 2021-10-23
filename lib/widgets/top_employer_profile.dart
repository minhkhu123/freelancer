import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_ntd.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils_data.dart';

class TopEmployerProfile extends StatelessWidget {
  final VoidCallback onPress;
  final bool isBack;

  TopEmployerProfile({this.onPress, this.isBack});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder<EmployerInfor>(
      stream: UtilsData.employerInfor().asStream(),
      initialData: EmployerInfor(name: '', avatar: '', linkAvatar: '', diem: 0),
      builder: (context, snapshot) => SizedBox(
        height: height * 0.26,
        child: Stack(
          children: [
            SizedBox(
              child: Image.asset(
                Images.topOngoingProject,
                fit: BoxFit.cover,
              ),
              height: height * 0.11,
            ),
            isBack == null
                ? Positioned(
                    left: 16,
                    top: height * 0.001,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.white,
                          size: 30,
                        ),
                        onPressed: onPress),
                  )
                : SizedBox(),
            Positioned(
              top: height * 0.06,
              left: 16,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: 110,
                    width: 110,
                    fit: BoxFit.cover,
                    imageUrl:
                    snapshot.data.linkAvatar != null ? (snapshot.data.linkAvatar + '/' + snapshot.data.avatar) : '',
                    placeholder: (context, url) => SizedBox(
                      child: CircularProgressIndicator(),
                      width: 10,
                      height: 10,
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      backgroundColor: AppColors.grey5,
                      child: SvgPicture.asset(
                        Images.user,
                        height: height * 0.05,
                        width: width * 0.5,
                        color: AppColors.white2,
                      ),
                    ),
                  )),
            ),
            Positioned(
              top: height * 0.13,
              left: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data.name != null ? snapshot.data.name : '',
                    style: AppTextStyles.regularW500(context,
                        size: 18, color: AppColors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    width: 152,
                    decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Số điểm còn lại: ${snapshot.data.diem}",
                        style: AppTextStyles.regularW700(context, size: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
