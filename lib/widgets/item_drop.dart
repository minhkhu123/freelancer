import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/models/drop_list_model.dart';

class ItemDrop extends StatelessWidget {
  const ItemDrop({Key key, this.width, this.list, this.title, this.onPress, this.height}) : super(key: key);
  final double width;
  final List list;
  final String title;
  final Function(OptionItem item) onPress;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [BoxShadow(color: AppColors.grey, blurRadius: 5, offset: Offset(0, 2))]),
        child: _buildDropListOption(context, list));
  }

  Widget _buildDropListOption(context, List listItem) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listItem.length,
      itemBuilder: (context, index) => _buildItem(context, listItem[index]),
    );
  }

  Widget _buildItem(context, item) {
    return GestureDetector(
      onTap: () {
        onPress(item);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: width,
        decoration: BoxDecoration(border: Border(top: BorderSide(width: 1, color: AppColors.grey6))),
        child: Text(
          item.title,
          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.hintText),
        ),
      ),
    );
  }
}
