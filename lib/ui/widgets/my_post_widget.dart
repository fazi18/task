import 'package:figme_task_app/constents/constant.dart';
import 'package:figme_task_app/logic/post_bloc/bloc/post_bloc.dart';
import 'package:figme_task_app/models/post.dart';
import 'package:figme_task_app/ui/widgets/custom_dialog_widget.dart';
import 'package:figme_task_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPostWidget extends StatelessWidget {
  final List<Post> posts;
  const MyPostWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 414.w,
      color: kMyPostContainerColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: posts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 136.h,
                width: 255.w,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12.55.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 43),
                            child: Text(
                              posts[index].title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: TextStyleUtile.boldTextStyle(
                                  fontSize: 14, color: kDarkTextColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 3.71),
                            child: Container(
                              height: 51.59.h,
                              child: Text(
                                posts[index].body,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyleUtile.normulTextStyle(
                                    fontSize: 11, color: kLightTextColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 23.64.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              myPostControlButton(Icons.edit, kLightTextColor,
                                  'Edit', context, index, false),
                              SizedBox(width: 17.w),
                              myPostControlButton(Icons.delete, kAccentColor,
                                  'Delete', context, index, true),
                            ],
                          )
                        ],
                      ),
                    )),
              );
            }),
      ),
    );
  }

  Row myPostControlButton(IconData icon, Color color, String title,
      BuildContext context, int index, bool isDelete) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            isDelete
                ? onDelete(context, posts[index].id)
                : onEdit(context, index);
          },
          child: Container(
            child: Row(
              children: [
                Center(
                    child: Icon(
                  icon,
                  color: color,
                  size: 8.h,
                )),
                SizedBox(width: 7.w),
                Text(
                  title,
                  style: TextStyleUtile.normulTextStyle(
                      fontSize: 11, color: color),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void onDelete(BuildContext context, String id) {
    // BlocProvider.of<SetPostBloc>(context).add(DeletePostEvent(id: id));
    showDialog(
        context: context,
        builder: (BuildContext context) => DeleteDialogWidget(id: id));
  }

  onEdit(BuildContext context, int index) {
    BlocProvider.of<SetPostBloc>(context)
        .add(SetPostShowValueEvent(index: index));
    Navigator.pushNamed(context, '/add_edit');
  }
}
