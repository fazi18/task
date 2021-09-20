import 'dart:ui';

import 'package:figme_task_app/constents/constant.dart';
import 'package:figme_task_app/models/album.dart';
import 'package:figme_task_app/models/post.dart';
import 'package:figme_task_app/models/user.dart';
import 'package:figme_task_app/ui/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultWidget extends StatelessWidget {
  final List<User> users;
  final List<Post> posts;
  final List<Album> albums;
  const SearchResultWidget(
      {required this.users,
      required this.posts,
      required this.albums,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text(
              'Users',
              style: boldTextStyle(fontSize: 14, color: kDarkTextColor),
            ),
            SizedBox(height: 8.h),
            _buildUserList(),
            SizedBox(height: 24.h),
            Text(
              'Posts',
              style: boldTextStyle(fontSize: 14, color: kSearchDarkTextColor),
            ),
            SizedBox(height: 8.h),
            buildPostList(posts),
            SizedBox(height: 16.h),
            Text(
              'Albums',
              style: boldTextStyle(fontSize: 14, color: kSearchDarkTextColor),
            ),
            SizedBox(height: 8.h),
            _buildAlbumList()
          ],
        ),
      ),
    );
  }

  Widget buildPostList(List<Post> posts) {
    return ListView.builder(
        itemCount: posts.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 87.h,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      posts[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: boldTextStyle(
                          fontSize: 14, color: kSearchDarkTextColor),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      posts[index].body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                          normulTextStyle(fontSize: 9, color: kLightTextColor),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '- ${users[users.indexWhere((user) => user.id == posts[index].userId)].name}',
                      style:
                          normulTextStyle(fontSize: 9, color: kLightTextColor),
                    ),
                    // SizedBox(height: 6.h),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildUserList() {
    return ListView.builder(
        itemCount: this.users.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 83.h,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: DetailScreenArguments(index: index),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
                child: Row(
                  children: [
                    Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          bottomLeft: Radius.circular(8.r),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(users[index].getGender() == 'men'
                              ? 'https://randomuser.me/api/portraits/men/${users[index].id}.jpg'
                              : 'https://randomuser.me/api/portraits/women/${users[index].id}.jpg'),
                        ),
                      ),
                    ),
                    SizedBox(width: 9.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          '@${users[index].username}',
                          maxLines: 1,
                          style:
                              boldTextStyle(fontSize: 11, color: kAccentColor),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          users[index].name,
                          maxLines: 1,
                          style: boldTextStyle(
                              fontSize: 14, color: kSearchDarkTextColor),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          users[index].email,
                          maxLines: 1,
                          style: normulTextStyle(
                              fontSize: 9, color: kLightTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // Column _buildColumnForUser(int index) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       SizedBox(height: 8),
  //       Text(
  //         '@${users[index].username}',
  //         maxLines: 1,
  //         style: boldTextStyle(fontSize: 11, color: kAccentColor),
  //       ),
  //       SizedBox(height: 8.h),
  //       Text(
  //         users[index].name,
  //         maxLines: 1,
  //         style: boldTextStyle(fontSize: 14, color: kSearchDarkTextColor),
  //       ),
  //       SizedBox(height: 4.h),
  //       Text(
  //         users[index].email,
  //         maxLines: 1,
  //         style: normulTextStyle(fontSize: 9, color: kLightTextColor),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildColumnForAlbum(int index) {
  //   int userIndex = users.indexWhere((user) => user.id == albums[index].userId);
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       SizedBox(height: 8.h),
  //       Text(
  //         albums[index].title,
  //         style: boldTextStyle(fontSize: 14, color: kSearchDarkTextColor),
  //       ),
  //       SizedBox(height: 9.h),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             height: 32.h,
  //             width: 32.w,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               image: DecorationImage(
  //                 fit: BoxFit.fill,
  //                 image: NetworkImage(
  //                     "https://randomuser.me/api/portraits/thumb/men/${users[userIndex].id}.jpg"),
  //               ),
  //             ),
  //           ),
  //           SizedBox(width: 9.w),
  //           Text(
  //             users[userIndex].name,
  //             style: normulTextStyle(fontSize: 14, color: kLightTextColor),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }

  Widget _buildAlbumList() {
    return ListView.builder(
        itemCount: this.albums.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 83.h,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              child: Row(
                children: [
                  Container(
                    width: 90.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.r),
                        bottomLeft: Radius.circular(8.r),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(users[users.indexWhere((user) =>
                                        user.id == albums[index].userId)]
                                    .getGender() ==
                                'men'
                            ? "https://randomuser.me/api/portraits/thumb/men/${users[users.indexWhere((user) => user.id == albums[index].userId)].id}.jpg"
                            : "https://randomuser.me/api/portraits/thumb/women/${users[users.indexWhere((user) => user.id == albums[index].userId)].id}.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(width: 9.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Text(
                          albums[index].title,
                          maxLines: 1,
                          softWrap: false,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: boldTextStyle(
                              fontSize: 14, color: kSearchDarkTextColor),
                        ),
                        SizedBox(height: 9.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 32.h,
                              width: 32.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(users[users.indexWhere(
                                                  (user) =>
                                                      user.id ==
                                                      albums[index].userId)]
                                              .getGender() ==
                                          'man'
                                      ? "https://randomuser.me/api/portraits/thumb/men/${users[users.indexWhere((user) => user.id == albums[index].userId)].id}.jpg"
                                      : "https://randomuser.me/api/portraits/thumb/women/${users[users.indexWhere((user) => user.id == albums[index].userId)].id}.jpg"),
                                ),
                              ),
                            ),
                            SizedBox(width: 9.w),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                users[users.indexWhere((user) =>
                                        user.id == albums[index].userId)]
                                    .name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: normulTextStyle(
                                    fontSize: 14, color: kLightTextColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  TextStyle normulTextStyle({required int fontSize, required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      height: 1,
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
