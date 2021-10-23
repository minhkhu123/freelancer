import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/item_drop.dart';
import 'package:get/get.dart';

class SelectDropList extends StatefulWidget {
  var itemList;
  final List list;
  final double paddingVertical;
  final Function(OptionItem item) onOption;
  final double height;
  final int index;
  final RxInt currentIndex;
  final String error;
  final bool isCity;

  SelectDropList(
      {@required this.list,
      @required this.itemList,
      @required this.onOption,
      this.paddingVertical = 15,
      this.height,
      this.index,
      this.currentIndex,
      this.error,
      this.isCity});

  @override
  _SelectDropListState createState() => _SelectDropListState();
}

class _SelectDropListState extends State<SelectDropList> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  bool isShow = false;

  TextEditingController searchFilterTextEditingController = TextEditingController();

  String get searchFilter => searchFilterTextEditingController.text;

  List<OptionItem> listSearch = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
    widget.currentIndex.listen((int value) {
      if (widget.index != value && isShow) {
        animationController.reverse();
        setState(() {});
      } else if (widget.index == value && !isShow) {
        animationController.forward();
        setState(() {});
      }
    });
    _runExpand();
  }

  void _runExpand() {
    if (isShow) {
      animationController.forward();
      widget.currentIndex.value = widget.index;
    } else {
      animationController.reverse();
      widget.currentIndex.value = 0;
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    searchFilterTextEditingController.dispose();
  }

  Future<void> getSearchListCityFilter() async {
    if (searchFilter == '' || searchFilter.isEmpty) {
      listSearch = widget.list;
    } else {
      listSearch = [];
      for (int i = 0; i < widget.list.length; i++) {
        if (widget.list.elementAt(i).title.toString().toLowerCase().contains(searchFilter.toLowerCase())) {
          listSearch.add(widget.list[i]);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: widget.paddingVertical),
      child: Column(
        children: <Widget>[
          CustomEditTextFreelancerRecruitment(
            hintText: widget.itemList.title,
            id: widget.itemList.id,
            textError: widget.error,
            onPress: () {
              widget.currentIndex.value = widget.index;
              if (widget.index == widget.currentIndex.value) {
                setState(() {
                  this.isShow = !this.isShow;
                  _runExpand();
                });
              }
            },
          ),
          SizeTransition(
            sizeFactor: animation,
            child: Column(
              children: [
                widget.isCity != null
                    ? TextField(
                        onChanged: (value) async{
                          await getSearchListCityFilter();
                        },
                        controller: searchFilterTextEditingController,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: AppColors.white,
                            contentPadding: EdgeInsets.all(5),
                            filled: true,
                            hintText: widget.isCity ? 'Nhập tỉnh thành phố' : 'Nhập tỉnh quận huyện',
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
                      )
                    : SizedBox(),
                ItemDrop(
                  width: width,
                  height: widget.height,
                  title: widget.itemList.title,
                  list: listSearch.isEmpty ? widget.list : listSearch,
                  onPress: (item) {
                    widget.itemList = item;
                    animationController.reverse();
                    widget.onOption(item);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
