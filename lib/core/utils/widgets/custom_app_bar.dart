import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.titleText,
    this.actions,
    this.actionsPadding,
    this.leading,
    this.title,
    this.isCenterTitle,
  });
  final String? titleText;
  final List<Widget>? actions;
  final Widget? leading;
  final EdgeInsetsGeometry? actionsPadding;
  final Widget? title;
  final bool? isCenterTitle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      actionsPadding: actionsPadding,
      actions: actions,
      leading:
          leading ??
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
      title:
          title ??
          Text(
            titleText ?? '',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,

              fontStyle: FontStyle.normal,
            ),
          ),
      centerTitle: isCenterTitle ?? true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
