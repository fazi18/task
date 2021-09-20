import 'package:figme_task_app/constents/constant.dart';
import 'package:figme_task_app/logic/album_bloc/bloc/album_bloc.dart';
import 'package:figme_task_app/logic/post_bloc/bloc/post_bloc.dart';
import 'package:figme_task_app/logic/user_bloc/bloc/user_bloc.dart';
import 'package:figme_task_app/models/album.dart';
import 'package:figme_task_app/models/post.dart';
import 'package:figme_task_app/models/user.dart';
import 'package:figme_task_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final postBloc;
  late final albumBloc;
  late final userBloc;

  @override
  void initState() {
    setData();
    super.initState();
  }

  void setData() {
    userBloc = BlocProvider.of<UserBloc>(context);
    albumBloc = BlocProvider.of<AlbumBloc>(context);
    postBloc = BlocProvider.of<PostBloc>(context);
    // args = ModalRoute.of(context)!.settings.arguments as DetailScreenArguments;
  }

  @override
  Widget build(BuildContext context) {
    // if (args == null)
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArguments;
    User user = getCurrentUser(args.index);
    return SafeArea(
      child: Scaffold(
        body: _buildDetailView(user),
      ),
    );
  }

  Widget _buildDetailView(User user) {
    return SingleChildScrollView(
      child: Container(
        color: kWhiteColor,
        child: Column(
          children: [
            _buildTopView(user),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  SizedBox(height: 23.h),
                  _buildAddressTitleView(),
                  SizedBox(height: 9.h),
                  _buildAddressDetailView(user),
                  SizedBox(height: 16.h),
                  InkWell(
                    onTap: () {
                      MapUtils.openMap(double.parse(user.address.geo.lat),
                          double.parse(user.address.geo.lat));
                    },
                    child: Container(
                      child: Text(
                        'VIEW ON MAP',
                        style: TextStyleUtile.boldTextStyle(
                            fontSize: 14, color: kAccentColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildMainTitle(Icons.person_pin_sharp, 'Comoany'),
                  SizedBox(height: 8.h),
                  _buildCompanyDetailView(user),
                  SizedBox(height: 24.h),
                  _buildMainTitle(Icons.album, 'Albums'),
                  SizedBox(height: 8.h),
                  _buildAlbumListView(user),
                  SizedBox(height: 24.h),
                  _buildMainTitle(Icons.post_add_rounded, 'Posts'),
                  SizedBox(height: 8.h),
                  _buildPostList(user),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPostList(User user) {
    postBloc.add(AllPostsEvent(userID: user.id));
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoadedState) {
          List<Post> posts = state.posts.postList;
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
                            style: TextStyleUtile.boldTextStyle(
                                fontSize: 14, color: kSearchDarkTextColor),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            posts[index].body,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleUtile.normulTextStyle(
                              fontSize: 9,
                              color: kLightTextColor,
                              hight: 1,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '- ${user.name}',
                            style: TextStyleUtile.normulTextStyle(
                              fontSize: 9,
                              color: kLightTextColor,
                              hight: 1,
                            ),
                          ),
                          // SizedBox(height: 6.h),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else if (state is PostErrorstate) {
          return Center(child: Text(state.error.toString()));
        }
        return Container();
      },
    );
  }

  Widget _buildAlbumListView(User user) {
    albumBloc.add(AlbumLoadeEvent(userID: user.id));
    return BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {
      if (state is AlbumLoadedState) {
        final List<Album> albums = state.allAlbums.albumList;
        return SizedBox(
          height: 100.h,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 16.w);
              },
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: albums.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 70.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 64.h,
                        width: 64.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              user.getGender() == 'man'
                                  ? "https://randomuser.me/api/portraits/thumb/men/${user.id}.jpg"
                                  : 'https://randomuser.me/api/portraits/thumb/women/${user.id}.jpg',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        albums[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleUtile.boldTextStyle(
                            fontSize: 12, color: kSearchDarkTextColor),
                      ),
                      Text(
                        '@${user.username}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleUtile.normulTextStyle(
                          fontSize: 9,
                          color: kLightTextColor,
                          hight: 1,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        );
      } else if (state is AlbumErrorState) {
        return Center(
          child: Text(state.error.toString()),
        );
      }
      return Container();
    });
  }

  Widget _buildCompanyDetailView(User user) {
    final List<String> catchPhrases = user.company.catchPhrase.split(' ');
    return Container(
      height: 132.h,
      decoration: BoxDecoration(
        color: kSearchDarkTextColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              user.company.name,
              style: TextStyleUtile.boldTextStyle(
                  fontSize: 24, color: kWhiteColor),
            ),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCatchPhraseView(catchPhrases[0]),
                SizedBox(width: 9.w),
                _buildCatchPhraseView(catchPhrases[1]),
                SizedBox(width: 9.w),
                _buildCatchPhraseView(catchPhrases[2]),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _buildCatchPhraseView(String catchPhrase) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 23.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: kWhiteColor,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          catchPhrase,
          textAlign: TextAlign.center,
          style: TextStyleUtile.normulTextStyle(
            fontSize: 11,
            color: kWhiteColor,
            hight: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildMainTitle(IconData icon, title) {
    return Row(
      children: [
        Icon(icon, size: 8.h, color: kSearchDarkTextColor),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyleUtile.boldTextStyle(
              fontSize: 16, color: kSearchDarkTextColor),
        ),
      ],
    );
  }

  Widget _buildAddressTitleView() {
    return Row(
      children: [
        _buildMainTitle(Icons.near_me_sharp, 'Address'),
        Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  BrowserUtil.openBrowser();
                },
                child: Icon(
                  Icons.alternate_email,
                  size: 16.h,
                  color: kLightTextColor,
                ),
              ),
              SizedBox(width: 16.25.w),
              Icon(
                Icons.phone,
                size: 16.w,
                color: kLightTextColor,
              ),
              SizedBox(width: 16.25.h),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/video_player');
                },
                child: Icon(
                  Icons.play_circle,
                  size: 16,
                  color: kLightTextColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAddressDetailView(User user) {
    return Container(
      height: 132.h,
      decoration: BoxDecoration(
        color: kAddressBoxBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _addressTitleText('City'),
                SizedBox(height: 4.h),
                _addressValueText(user.address.city),
                SizedBox(height: 16.h),
                _addressTitleText('Street'),
                SizedBox(height: 4.h),
                _addressValueText(user.address.street),
              ],
            ),
            SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _addressTitleText('Sute'),
                SizedBox(height: 4.h),
                _addressValueText(user.address.suite),
                SizedBox(height: 16.h),
                _addressTitleText('Zip Code'),
                SizedBox(height: 4.h),
                _addressValueText(user.address.zipcode),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text _addressTitleText(String title) {
    return Text(
      title,
      style: TextStyleUtile.boldTextStyle(fontSize: 14, color: kLightTextColor),
    );
  }

  Text _addressValueText(String value) {
    return Text(
      value,
      style: TextStyleUtile.normulTextStyle(
        fontSize: 14,
        color: kSearchDarkTextColor,
      ),
    );
  }

  Column _buildTopView(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 248.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    user.getGender() == 'man'
                        ? "https://randomuser.me/api/portraits/men/${user.id}.jpg"
                        : "https://randomuser.me/api/portraits/women/${user.id}.jpg",
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '@${user.username}',
                      style: TextStyleUtile.boldTextStyle(
                        fontSize: 12,
                        color: kUsernameColor,
                      ),
                    ),
                    Text(
                      user.name,
                      style: TextStyleUtile.boldTextStyle(
                        fontSize: 18,
                        color: kWhiteColor,
                      ),
                    ),
                    Text(
                      user.email,
                      style: TextStyleUtile.normulTextStyle(
                          fontSize: 14, color: kWhiteColor, hight: 1),
                    ),
                    SizedBox(
                      height: 8.h,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: 2.h,
                left: 6.w,
                child: IconButton(
                  icon: Container(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: kWhiteColor,
                      size: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            Positioned(
                top: 2.h,
                right: 6.w,
                child: IconButton(
                  icon: Container(
                    child: Icon(
                      Icons.search,
                      color: kWhiteColor,
                      size: 16,
                    ),
                  ),
                  onPressed: () {},
                )),
          ],
        )
      ],
    );
  }

  User getCurrentUser(int index) {
    final userState = userBloc.state;
    late User user;
    if (userState is UserLoadedState) {
      user = userState.users.userList[index];
    } else if (userState is UserSearchState) {
      user = userState.users[index];
    }
    return user;
  }

  // TextStyle normulTextStyle({required int fontSize, required Color color}) {
  //   return TextStyle(
  //     height: 1,
  //     fontWeight: FontWeight.w400,
  //     fontSize: fontSize.sp,
  //     color: color,
  //   );
  // }

  // TextStyle boldTextStyle({required int fontSize, required Color color}) {
  //   return TextStyle(
  //     fontWeight: FontWeight.w700,
  //     fontSize: fontSize.sp,
  //     color: color,
  //   );
  // }
}

class DetailScreenArguments {
  final int index;

  DetailScreenArguments({required this.index});
}
