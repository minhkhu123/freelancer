import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/screens/home/album_folder.dart';
import 'package:album_app/widges/ct_textfield_search.dart';
import 'package:album_app/widges/folder_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: IconButton(
          icon: Image.asset(Images.ic_add_folder),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {
            // Get.offAllNamed();
          },
              icon: Icon(Icons.logout)),
        ],
        title: Text('Album',style: AppTextStyles.regularW500(context, size: 18),),
        centerTitle: true,
      ),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 10),
                CustomSearchTextField(),
                Container(
                  height: height * 0.74,
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 18),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: 10,
                      itemBuilder: (BuildContext ctx, index) {
                        return FolderNormal(
                          title: 'Giày',
                          onPress: () {
                            Get.to(AlbumFolder());
                          },
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
    ));
  }
}
