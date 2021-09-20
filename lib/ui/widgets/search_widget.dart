import 'package:figme_task_app/constents/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: kLightTextColor);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: kLightGray,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
