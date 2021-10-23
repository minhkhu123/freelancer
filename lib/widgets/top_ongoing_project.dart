import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_uv.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/models/drop_list_model.dart';

import '../common/images.dart';
import '../common/theme/app_color.dart';
import '../common/theme/app_text_style.dart';

class TopOnGoingProject extends StatelessWidget {
  final VoidCallback onPress;
  final bool isBack;

  TopOnGoingProject({Key key, this.onPress, this.isBack}) : super(key: key);
  final DropListModel dropListModelSex =
      DropListModel(listItem: [OptionItem(id: 1, title: "Nam"), OptionItem(id: 2, title: "Nữ"), OptionItem(id: 3, title: 'Khác')]);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder<UserInfor>(
        stream: UtilsData.userInfo().asStream(),
        initialData: UserInfor(ten: '', pathAvt: '', avatar: '', tuoi: '', gioiTinh: '1', tinhThanhTxt: '', luotXem: ''),
        builder: (context, snapshot) => SizedBox(
              height: height * 0.27,
              child: Stack(
                children: [
                  SizedBox(
                    child: Image.asset(
                      Images.topOngoingProject,
                      fit: BoxFit.cover,
                    ),
                    height: height * 0.11,
                    width: width,
                  ),
                  isBack == null
                      ? Positioned(
                          left: 16,
                          top: height * 0.002,
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
                        imageUrl: snapshot.data.pathAvt != null ? (snapshot.data.pathAvt + "/" + snapshot.data.avatar) : '',
                        placeholder: (context, url) => SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(),
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
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.13,
                    left: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data.ten != null ? snapshot.data.ten : '',
                          style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "${dropListModelSex.listItem[int.parse(snapshot.data.gioiTinh) - 1].title}, ${snapshot.data.tuoi}, ${snapshot.data.tinhThanhTxt}",
                            style: AppTextStyles.regularW400(context, size: 13, color: AppColors.black),
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Images.ic_eye,
                              color: AppColors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${snapshot.data.luotXem} lượt xem",
                              style: AppTextStyles.regularW400(context, size: 11, color: AppColors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
