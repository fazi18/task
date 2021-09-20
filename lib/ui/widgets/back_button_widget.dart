import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final Color IconColor;
  const BackButtonWidget({
    Key? key,
    required this.IconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: IconColor,
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
