import 'package:figme_task_app/constents/constant.dart';
import 'package:figme_task_app/logic/post_bloc/bloc/post_bloc.dart';
import 'package:figme_task_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteDialogWidget extends StatelessWidget {
  final String id;
  const DeleteDialogWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 127.0.h,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 12.h),
              Text(
                'Delete Post',
                style: TextStyleUtile.boldTextStyle(
                    fontSize: 16, color: kDarkTextColor),
              ),
              SizedBox(height: 11.h),
              Text(
                'You are about to delete post ‘Name of post’. Please confirm to delete or cancel',
                style: TextStyleUtile.normulTextStyle(
                    fontSize: 14, color: kDarkTextColor),
              ),
              // SizedBox(height: 17.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyleUtile.normulTextStyle(
                          fontSize: 16, color: kLightTextColor, hight: 2),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<SetPostBloc>(context)
                            .add(DeletePostEvent(id: id));
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Delete Post',
                        style: TextStyleUtile.normulTextStyle(
                            fontSize: 16, color: kAccentColor, hight: 2),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
