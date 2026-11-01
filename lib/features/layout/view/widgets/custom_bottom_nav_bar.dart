part of '../layout_screen.dart';

class _CustomBottmNavBar extends StatelessWidget {
  const _CustomBottmNavBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        final cubit = context.read<LayoutCubit>();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(height: 1, thickness: 1, color: theme.dividerColor),
            NavigationBar(
              backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
              selectedIndex: cubit.selectedIndex,
              onDestinationSelected: (index) {
                cubit.changeNavBarIndex(index);
              },
              indicatorShape: CircleBorder(),
              indicatorColor: AppColors.primaryColor,
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.inventory_2_outlined),
                  selectedIcon: Icon(Icons.inventory),
                  label: 'Orders',
                ),

                NavigationDestination(
                  icon: Icon(Icons.add_box_outlined),
                  selectedIcon: Icon(Icons.add_box),
                  label: 'Add Product',
                ),

                NavigationDestination(
                  icon: Icon(Icons.add_chart_outlined),
                  selectedIcon: Icon(Icons.add_chart),
                  label: 'Add sales',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
