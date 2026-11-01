part of '../add_product_screen.dart';

class IsTreindingSwitch extends StatelessWidget {
  const IsTreindingSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Is Trending Product',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Show this product in trending section',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: cubit.isTrending,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primaryColor,
            onChanged: (value) {
              cubit.changeIsTrending(value);
            },
          ),
        ],
      ),
    );
  }
}
