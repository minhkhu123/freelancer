import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';

class CustomTextFieldSearch extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final VoidCallback onPressed;
  final String hintText;
  final FocusNode focusNode;

  const CustomTextFieldSearch({Key key, this.onChanged, this.textEditingController, this.hintText, this.onPressed, this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Center(
        child: TextField(
          onChanged: (value) {
            if (onChanged != null) onChanged(value);
          },
          controller: textEditingController,
          focusNode: focusNode,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          decoration: InputDecoration(
            fillColor: AppColors.white,
              contentPadding: EdgeInsets.all(5),
              filled: true,
              hintText: (hintText),
              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.hintText),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              prefixIcon: GestureDetector(
                onTap: onPressed,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: SvgPicture.asset(
                    Images.ic_search,
                    color: AppColors.hintText,
                    height: 10,
                    width: 10,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
