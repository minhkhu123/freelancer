import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/update_profile_ntd/update_profile_ntd_controller.dart';
import 'package:get/get.dart';

class DialogSelectionImage extends StatelessWidget {
  DialogSelectionImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Container(
        height: height * 0.4,
        width: width,
        child: GetBuilder<UpdateProfileNTDController>(
          init: UpdateProfileNTDController(),
          builder: (controller) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Obx(() => ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: controller.img.path,
                          width: 130,
                          height: 130,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, error, stackTrace) => ClipRRect(
                            child: Image.file(
                              controller.img,
                              height: 130,
                              width: 130,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => CircleAvatar(
                                backgroundColor: AppColors.grey5,
                                radius: 65,
                                child: SvgPicture.asset(
                                  Images.user,
                                  height: height * 0.05,
                                  width: width * 0.5,
                                  color: AppColors.white2,
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: controller.getImageFromCamera,
                    child: Text(
                      "Chụp ảnh",
                      style: AppTextStyles.regularW500(context, size: 16, color: AppColors.blue),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: controller.getImgFromGallery,
                    child: Text(
                      "Chọn từ thư viện",
                      style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 56,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    child:ElevatedButton(
                        onPressed: controller.checkImg,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.orange),
                        ),
                        child: Text(
                          "Cập nhật",
                          style: AppTextStyles.regularW700(context, size: 17),
                        )),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    child: ElevatedButton(
                        onPressed: controller.onCancel,
                        child: Text(
                          "Hủy",
                          style: AppTextStyles.regularW700(context, size: 17),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
