import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:album_app/widges/ct_textfield_search.dart';
import 'package:album_app/widges/image_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumFolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.blue,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios
              ),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(Images.ic_add_image),
              ),
            ],
            title: Text('Giày',style: AppTextStyles.regularW500(context, size: 18),),
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
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: 30,
                      itemBuilder: (BuildContext ctx, index) {
                        return ImageFile(
                          title: 'DTT-30',
                          money: '1000000',
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
