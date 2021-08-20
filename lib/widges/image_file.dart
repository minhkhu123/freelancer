import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ImageFile extends StatelessWidget {
  final String title;
  final String money;
  final VoidCallback onPress;
  final VoidCallback like;
  final VoidCallback delete;
  final String urlImage;
  final bool isLiked;

  const ImageFile({Key key, this.title, this.money, this.onPress, this.like, this.delete, this.urlImage, this.isLiked}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          Container(
            height: height * 0.33,
            width: width * 0.6,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.blue1,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Container(
                    height: height * 0.23,
                    width: width * 0.5,
                    child: Image.network(urlImage)),
                SizedBox(height: 20),
                Positioned(
                  top: 3,
                  left: 13,
                  child: InkWell(
                    onTap: like,
                    child: Container(
                        height: 20,
                        width: 20,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: AppColors.red1,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: SvgPicture.asset(Images.ic_heart,color: isLiked ? AppColors.red : AppColors.white,)
                    ),
                  ),
                ),
                Positioned(
                  top: 3,
                    left: 60,
                    child: Text(title,style: AppTextStyles.regularW500(context, size: 14,color: AppColors.black),),
                ),
                Positioned(
                  bottom: 0,
                    left: 6,
                    child: Container(
                      height: 17,
                      width: width * 0.41,
                      color: AppColors.orange,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Images.ic_money,height: 20,width: 20,),
                          SizedBox(width: 2),
                          Text(money,style: AppTextStyles.regularW700(context, size: 14,color: AppColors.black),),
                          Text('đ',style: AppTextStyles.regularW700(context, size: 14,color: AppColors.black),),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
          Positioned(
            top: -2,
            right: -2,
            child: InkWell(
              onTap: delete,
              child: Container(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset(Images.ic_delete)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
