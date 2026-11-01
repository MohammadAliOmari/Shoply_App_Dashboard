part of '../layout_screen.dart';

class _LayoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _LayoutAppBar({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return _CustomLayoutAppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _CustomLayoutAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _CustomLayoutAppBar({this.title});
  final Widget? title;
  @override
  Widget build(BuildContext context) {
    return AppBar(scrolledUnderElevation: 0, title: title, centerTitle: true);
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
