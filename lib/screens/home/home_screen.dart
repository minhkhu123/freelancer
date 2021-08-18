import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/album_folder.dart';
import 'package:album_app/screens/home/home_controller.dart';
import 'package:album_app/widges/ct_textfield_search.dart';
import 'package:album_app/widges/dialog_folder.dart';
import 'package:album_app/widges/folder_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          leading: IconButton(
            icon: Image.asset(Images.ic_add_folder),
            onPressed: () {
              Get.dialog(DialogFolder());
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  controller.logOut();
                },
                icon: Icon(Icons.logout)),
          ],
          title: Text(
            'Album',
            style: AppTextStyles.regularW500(context, size: 18),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 10),
              CustomSearchTextField(
                textEditingController: controller.searchFolderTextEditingController,
              ),
              Container(
                height: height * 0.74,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                    itemCount: controller.folderModel.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return FolderNormal(
                        title: controller.folderModel[index].name,
                        onPress: () {
                          controller.nameFolder.value = controller.folderModel[index].name;
                          controller.checkNameFolder();
                          Get.to(AlbumFolder());
                        },
                        favorite: controller.folderModel[index].favorite,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
