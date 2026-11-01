import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app_dashboard/core/utils/theme/app_colors.dart';
import 'package:shoply_app_dashboard/features/layout/view_model/cubit.dart';
import 'package:shoply_app_dashboard/features/layout/view_model/state.dart';
part 'widgets/custom_bottom_nav_bar.dart';
part 'widgets/layout_app_bar.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          final cubit = context.read<LayoutCubit>();
          return Scaffold(
            appBar: _LayoutAppBar(
              title: cubit.appbarTitle[cubit.selectedIndex],
            ),
            bottomNavigationBar: _CustomBottmNavBar(),
            body: cubit.pages[cubit.selectedIndex],
          );
        },
      ),
    );
  }
}
