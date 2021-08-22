import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_button_auth.dart';
import 'package:album_app/widges/ct_textfield_create_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DialogCreateInfoImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Dialog(
          insetPadding: EdgeInsets.only(top: 10.0),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(horizontal: 14),
            // padding: EdgeInsets.symmetric(horizontal: 35),
            height: 330,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                      child: Text(
                    'Tạo thông tin cho ảnh',
                    style: AppTextStyles.regularW500(context, size: 24, color: AppColors.blue),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                    child: Divider(
                      color: AppColors.grey,
                      thickness: 0.5,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mã sản phẩm:',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                        ),
                        CustomTextFieldCreateInfo(
                          hintText: 'Nhập mã sản phẩm',
                          surfix: '',
                          textEditingController: controller.codeTextEditingController,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Giá sản phẩm:',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                        ),
                        CustomTextFieldCreateInfo(
                          hintText: 'Nhập giá sản phẩm',
                          surfix: 'VNĐ',
                          textEditingController: controller.moneyTextEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonAuth(
                        width: width * 0.3,
                        title: 'Tạo thông tin',
                        onPressed: controller.codeTextEditingController.text.isEmpty || controller.moneyTextEditingController.text.isEmpty
                            ? null
                            : controller.isMulti.value
                                ? () {
                                    controller.addMultiImage(controller.folderId.value, controller.codeTextEditingController.text,
                                        controller.moneyTextEditingController.text, false);
                                    print('multi');
                                  }
                                : () {
                                    controller.addImage(controller.folderId.value, controller.codeTextEditingController.text,
                                        controller.moneyTextEditingController.text, false);
                                    print('single');
                                  },
                      ),
                      SizedBox(width: 10),
                      CustomButtonAuth(
                        width: width * 0.3,
                        title: 'Hủy',
                        onPressed: () {
                          Get.back();
                          controller.codeTextEditingController.clear();
                          controller.moneyTextEditingController.clear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
