import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class ItemListCheckBox extends StatelessWidget {
  const ItemListCheckBox({Key key, this.text, this.isCheck, this.onChanged}) : super(key: key);
  final String text;
  final bool isCheck;
  final Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isCheck,
          onChanged: onChanged,
        ),
        Text(
          text.replaceFirst(text[0], text[0].toUpperCase()),
          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
        )
      ],
    );
  }
}
