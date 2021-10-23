import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class ItemSkill extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  const ItemSkill({Key key, this.text, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: AppTextStyles.regularW500(context,
                size: 15, color: AppColors.blue)),
        SizedBox(width: 10),
        GestureDetector(
          onTap: onPress,
            child: Text("Xóa bỏ",
                style: AppTextStyles.regularW500(context,
                    size: 15, color: AppColors.red))),
      ],
    );
  }
}
