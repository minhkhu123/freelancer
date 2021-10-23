import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({
    Key key,
    this.text,
    this.image,
    this.onPress,
  }) : super(key: key);

  final String text, image;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Column(
        children: [
          Image.asset(
            image,
            height: height * 0.4,
            width: width * 0.9,
          ),
          InkWell(
            onTap: onPress,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.white,
              )),
            ),
          ),
          SizedBox(height: 13),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.blue),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
