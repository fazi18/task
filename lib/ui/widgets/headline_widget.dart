import 'package:figme_task_app/constents/constant.dart';
import 'package:flutter/material.dart';

class MainHeadline extends StatelessWidget {
  final String mainHeadlineText;
  final String subHeadlineText;
  const MainHeadline({
    Key? key,
    required this.mainHeadlineText,
    required this.subHeadlineText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(mainHeadlineText, style: kMainHeadlineTextStyle),
        Text(subHeadlineText, style: kSubHeadlineTextStyle),
      ],
    );
  }
}
