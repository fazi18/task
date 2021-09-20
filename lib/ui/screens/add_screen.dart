import 'package:figme_task_app/constents/constant.dart';
import 'package:figme_task_app/logic/post_bloc/bloc/post_bloc.dart';
import 'package:figme_task_app/ui/widgets/back_button_widget.dart';
import 'package:figme_task_app/ui/widgets/post_created_successfully_widget.dart';
import 'package:figme_task_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late SetPostBloc setPostBloc;
  final _idController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  bool _wasIdExist = false;
  bool _isSubmitClicked = false;
  String query = '';
  String errorText = '';

  @override
  void initState() {
    setPostBloc = BlocProvider.of<SetPostBloc>(context);
    _setTextOnController(setPostBloc.state);
    super.initState();
  }

  void _setTextOnController(var state) {
    if (state is PostValueShowState) {
      _idController.text = state.myPosts[state.index].id;
      _titleController.text = state.myPosts[state.index].title;
      _bodyController.text = state.myPosts[state.index].body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<SetPostBloc, PostState>(
          builder: (context, state) {
            if (state is PostSetState && _isSubmitClicked) {
              return PostCreatedSuccessfullyWidget();
            }
            return _buildBody();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
        color: kBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            BackButtonWidget(IconColor: Colors.black),
            SizedBox(height: 22.h),
            Center(child: _buildMainTitleText()),
            SizedBox(height: 42.h),
            _buildForm(),
            Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: _buildSaveButton(
                    _wasIdExist ? kLightTextColor : kAccentColor, context)),
            SizedBox(height: 27.h)
          ],
        ));
  }

  Widget _buildMainTitleText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Create New Post',
          style:
              TextStyleUtile.boldTextStyle(fontSize: 24, color: kDarkTextColor),
        ),
        Text(
          'Add or edit post here',
          style: TextStyleUtile.normulTextStyle(
              fontSize: 14, color: kLightTextColor),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 42.h),
          _buildSubTitleText('Post ID:'),
          SizedBox(height: 7.h),
          _buildSingleTextField(_idController,
              _wasIdExist ? kAccentColor : kLightTextColor, true),
          SizedBox(height: 4.h),
          _buildErrorMessage(),
          SizedBox(height: 16.h),
          _buildSubTitleText('Psot Title'),
          SizedBox(height: 7.h),
          _buildSingleTextField(_titleController, kLightTextColor, false),
          SizedBox(height: 16.h),
          _buildSubTitleText('Psot Body'),
          SizedBox(height: 7.h),
          _buildPostBodyTextField(),
        ],
      ),
    );
  }

  Text _buildSubTitleText(String title) {
    return Text(
      title,
      style: TextStyleUtile.boldTextStyle(fontSize: 14, color: kDarkTextColor),
    );
  }

  Widget _buildSingleTextField(
      TextEditingController controller, Color borderColor, bool isIdField) {
    return TextField(
      controller: controller,
      maxLength: isIdField ? null : 80,
      keyboardType: isIdField ? TextInputType.number : TextInputType.name,
      style: TextStyleUtile.normulTextStyle(
          fontSize: 14, color: kDarkLightTextColor),
      onChanged: isIdField ? _checkIdIsExist : null,
      decoration: InputDecoration(
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 20, top: 15),
        suffixIcon: IconButton(
          // padding: EdgeInsets.only(
          //   bottom: (1 - 1) * 18.0,
          //   top: isSingleLine ? 0 : 5,
          // ),
          icon: Icon(
            Icons.clear,
            size: 15.5.h,
          ),
          onPressed: () => controller.clear(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }

  Widget _buildPostBodyTextField() {
    return Container(
      height: 130,
      child: TextField(
        controller: _bodyController,
        maxLength: 180,
        maxLines: 8,
        minLines: 8,
        keyboardType: TextInputType.name,
        style: TextStyleUtile.normulTextStyle(
            fontSize: 14, color: kDarkLightTextColor),
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(left: 20, top: 15),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(
              bottom: (5 - 1) * 18.0,
            ),
            icon: Icon(
              Icons.clear,
              size: 15.5.h,
            ),
            onPressed: () => _bodyController.clear(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: kLightTextColor),
          ),
        ),
      ),
    );
  }

  void _checkIdIsExist(String id) {
    List<String> ids = [];
    var state = setPostBloc.state;
    if (state is PostSetState) {
      for (var post in state.myPosts) {
        ids.add(post.id);
      }
      if (ids.contains(id)) {
        setState(() {
          _wasIdExist = true;
          errorText = 'This id already exist';
        });
      } else {
        setState(() {
          _wasIdExist = false;
          errorText = '';
        });

        // setPostBloc.add(SetPostIdExistEvent(posts: state.myPosts));
      }
    }
  }

  Widget _buildErrorMessage() {
    return Text(
      errorText,
      style: TextStyleUtile.normulTextStyle(fontSize: 11, color: kAccentColor),
    );
  }

  postData(context) {
    // setPostBloc.add(PostInitialEvent());
    _isSubmitClicked = true;
    String id = _idController.text;
    String title = _titleController.text;
    String body = _bodyController.text;
    var state = setPostBloc.state;
    if (id == '') {
      setState(() {
        errorText = 'Pleas put ID!';
      });
    } else {
      if (state is PostValueShowState) {
        setPostBloc.add(SetPostEditEvent(
            index: state.index, id: id, title: title, body: body));
      } else {
        setPostBloc.add(SetPostEvent(body: body, title: title, id: id));
      }
    }
  }

  Widget _buildSaveButton(Color color, BuildContext context) {
    return InkWell(
      onTap: _wasIdExist
          ? null
          : () {
              postData(context);
            },
      child: Container(
        height: 46.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child: BlocBuilder<SetPostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoadingState) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircularProgressIndicator(
                    color: kWhiteColor,
                  ),
                );
              }
              return Text(
                'SAVE POST',
                style: TextStyleUtile.boldTextStyle(
                    fontSize: 14, color: kWhiteColor),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_isSubmitClicked == false) {
      PostState state = setPostBloc.state;
      if (state is PostValueShowState) {
        setPostBloc.add(BackToSetStateEvent());
      }
    }

    _idController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
