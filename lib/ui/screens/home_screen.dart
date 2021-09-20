import 'package:figme_task_app/constents/constant.dart';
import 'package:figme_task_app/logic/album_bloc/bloc/album_bloc.dart';
import 'package:figme_task_app/logic/post_bloc/bloc/post_bloc.dart';
import 'package:figme_task_app/logic/user_bloc/bloc/user_bloc.dart';
import 'package:figme_task_app/models/post.dart';
import 'package:figme_task_app/models/user.dart';
import 'package:figme_task_app/ui/widgets/my_post_widget.dart';
import 'package:figme_task_app/ui/widgets/search_result_widget.dart';
import 'package:figme_task_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'detail_screen.dart';
import '../widgets/headline_widget.dart';
import '../widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<User> _userList;
  late UserBloc _userBloc;
  String _query = '';
  late SetPostBloc setPostBloc;
  late PostBloc _postBloc;
  late AlbumBloc _albumBloc;
  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() async {
    _postBloc = BlocProvider.of<PostBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    _albumBloc = BlocProvider.of<AlbumBloc>(context);
    setPostBloc = BlocProvider.of<SetPostBloc>(context);
    _userBloc.add(FatchUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: homeAppBar(),
        body: BlocBuilder<UserBloc, UserState>(
            builder: (BuildContext context, UserState state) {
          if (state is UserListErrorstate) {
            final error = state.error;
            return Text(error);
          } else if (state is UserLoadedState) {
            return _buildView(state.users.userList);
          } else if (state is UserSearchState) {
            return _buildSearchedView(state.users);
          } else if (state is UserEmptyListState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyleUtile.boldTextStyle(
                    fontSize: 16, color: kLightTextColor),
              ),
            );
          } else if (state is UserFilterState) {
            return _buildView(state.filteredUsers);
          }
          return Center(child: CircularProgressIndicator());
        }),
        floatingActionButton: _buildFloationgActionButon(),
      ),
    );
  }

  Widget _buildView(List<User> users) {
    _userList = users;
    return BlocBuilder<SetPostBloc, PostState>(builder: (context, state) {
      if (state is PostSetState) {
        if (state.myPosts.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: MyPostWidget(posts: state.myPosts),
                flex: 3,
              ),
              Expanded(
                child: _buildAllUserListWithTitle(users),
                flex: 7,
              ),
            ],
          );
        }
      }
      return _buildAllUserList(users);
    });
  }

  Widget _buildAllUserList(List<User> users) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 13, bottom: 13),
      child: GridView.builder(
        itemCount: users.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 24.h,
          mainAxisSpacing: 24.h,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: DetailScreenArguments(index: index),
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 190.h,
                  width: 165,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(users[index].getGender() == 'man'
                          ? "https://randomuser.me/api/portraits/men/${users[index].id}.jpg"
                          : "https://randomuser.me/api/portraits/women/${users[index].id}.jpg"),
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
                          '@${users[index].username}',
                          style: TextStyleUtile.boldTextStyle(
                            fontSize: 11,
                            color: kUsernameColor,
                          ),
                        ),
                        Text(
                          users[index].name,
                          style: TextStyleUtile.boldTextStyle(
                            fontSize: 14,
                            color: kWhiteColor,
                          ),
                        ),
                        Text(
                          users[index].email,
                          style: TextStyleUtile.normulTextStyle(
                            fontSize: 9,
                            color: kWhiteColor,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAllUserListWithTitle(List<User> users) {
    return Material(
      elevation: 20,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 14.h),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Text(
                  'All User',
                  style: TextStyleUtile.boldTextStyle(
                      fontSize: 16, color: kDarkTextColor),
                ),
              ),
            ),
            Expanded(
              child: _buildAllUserList(users),
              flex: 10,
            )
          ],
        ),
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      toolbarHeight: 245.0,
      backgroundColor: Colors.white,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.only(left: 68.0.w, right: 68.0.w),
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(height: 18.0),
            SearchWidget(
              hintText: 'Tap to search by username, email or name',
              text: _query,
              onChanged: searchUser,
            ),
            SizedBox(height: 21.0),
            Row(
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserSearchState) {
                      return MainHeadline(
                        mainHeadlineText: 'Search Results',
                        subHeadlineText:
                            '${state.users.length} Result is found',
                      );
                    } else if (state is UserEmptyListState) {
                      return MainHeadline(
                        mainHeadlineText: 'Search Results',
                        subHeadlineText: '0 Result is found',
                      );
                    } else if (state is UserFilterState) {
                      return MainHeadline(
                        mainHeadlineText: '${state.filterValue} Users',
                        subHeadlineText:
                            'List of ${state.filterValue} active users',
                      );
                    }
                    return BlocBuilder<SetPostBloc, PostState>(
                      builder: (context, state) {
                        if (state is PostSetState) {
                          return MainHeadline(
                              mainHeadlineText: 'Your Posts',
                              subHeadlineText:
                                  'You can create & edit your posts here');
                        }
                        return BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            return MainHeadline(
                              mainHeadlineText: 'All Users',
                              subHeadlineText: 'List of active users',
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 6.h,
                ),
                Spacer(),
                _buildFilterButton()
              ],
            ),
            // SizedBox(
            //   height: 8.h,
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      margin: EdgeInsets.only(right: 17.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          elevation: 0,
          icon: Icon(
            Icons.filter_list_alt,
            size: 16.h,
            color: kLightTextColor,
          ),
          hint: null,
          items: <String>['Men', 'Women', 'All Users'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: TextStyleUtile.boldTextStyle(
                      fontSize: 14, color: kLightTextColor)),
            );
          }).toList(),
          onChanged: _filterListChanged,
        ),
      ),
    );
  }

  void _filterListChanged(String? value) {
    if (value == 'All Users') {
      _userBloc.add(AllUserFilterEvent());
    } else if (value != null) {
      _userBloc.add(UserGenderFilterEvent(userFilterValue: value));
    }
  }

  void searchUser(String query) {
    final users = _userList.where((user) {
      final nameLower = user.name.toLowerCase();
      final emailLower = user.email.toLowerCase();
      final usernameLower = user.username.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower) ||
          usernameLower.contains(searchLower) ||
          emailLower.contains(searchLower);
    }).toList();
    this._query = query;
    if (query == '') {
      _userBloc.add(BackUserLoadedEvent());
    } else if (users.isEmpty) {
      _userBloc.add(EmptyUserListEvent());
    } else
      _userBloc.add(SearchUserEvent(users: users));
  }

  Widget _buildSearchedView(List<User> users) {
    _postBloc.add(AllPostsEvent(userID: users[0].id));
    _albumBloc.add(AlbumLoadeEvent(userID: users[0].id));
    List<Post> searchedPosts;
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostLoadedState) {
        searchedPosts = state.posts.postList;
        return BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumLoadedState) {
              return SearchResultWidget(
                posts: searchedPosts,
                users: users,
                albums: state.allAlbums.albumList,
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  FloatingActionButton _buildFloationgActionButon() {
    return FloatingActionButton(
        backgroundColor: kAccentColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_edit');
        });
  }
}
