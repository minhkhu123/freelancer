import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/theme/app_color.dart';

class CustomTextFieldRegister extends StatefulWidget {
  final TextEditingController textEditingController;
  final VoidCallback onPressed;
  final bool isPassword;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final SvgPicture iconData;
  final String hintText;
  final int length;
  final FocusNode focusNode;
  final String error;
  final List<TextInputFormatter> inputFormatters;

  const CustomTextFieldRegister(
      {Key key,
      this.isPassword,
      this.keyboardType,
      this.iconData,
      this.onChanged,
      this.textEditingController,
      this.hintText,
      this.onPressed,
      this.focusNode,
      this.error,
      this.inputFormatters,
      this.length});

  @override
  _CustomTextFieldRegisterState createState() => _CustomTextFieldRegisterState();
}

class _CustomTextFieldRegisterState extends State<CustomTextFieldRegister> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        obscureText: !widget.isPassword,
        onChanged: (value) {
          if (widget.onChanged != null) widget.onChanged(value);
        },
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.hintText),
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: AppColors.hintText),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            isDense: true,
            suffixIcon: IconButton(
              icon: widget.iconData,
              onPressed: widget.onPressed,
            ),
            errorText: widget.error,
            counter: SizedBox.shrink()),
        maxLength: widget.length,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
