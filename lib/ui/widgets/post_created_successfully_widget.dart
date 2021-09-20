import 'package:figme_task_app/constents/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCreatedSuccessfullyWidget extends StatelessWidget {
  const PostCreatedSuccessfullyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 62.h,
              width: 62.w,
              child: Image.asset('assets/images/success.jpg'),
            ),
            SizedBox(height: 39.h),
            Text(
              'Post  Created Successfully',
              style: boldTextStyle(fontSize: 24, color: kDarkTextColor),
            ),
            Text(
              'You can see post on your home screen',
              style: normulTextStyle(fontSize: 14, color: kLightTextColor),
            ),
            SizedBox(
              height: 52.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              child: Container(
                width: double.infinity.w,
                height: 46.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(
                      color: kAccentColor,
                      width: 1,
                    )),
                child: Center(
                  child: Text(
                    'BACK TO HOME',
                    style: boldTextStyle(
                      fontSize: 14,
                      color: kAccentColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle normulTextStyle({required int fontSize, required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: fontSize.sp,
      color: color,
    );
  }

  TextStyle boldTextStyle({required int fontSize, required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: fontSize.sp,
      color: color,
    );
  }
}
