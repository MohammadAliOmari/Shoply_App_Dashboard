import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app_dashboard/core/utils/theme/app_colors.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_button.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_loading.dart';
import 'package:shoply_app_dashboard/features/sales/view_model/cubit.dart';
import 'package:shoply_app_dashboard/features/sales/view_model/state.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddSalesCubit(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<AddSalesCubit, AddSalesState>(
              listener: (context, state) {
                if (state is AddSalesLoadingState) {
                  return CustomLoading.showDialogLoading(context: context);
                }
                if (state is AddSalesSuccessState) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sales Banner added successfully'),
                    ),
                  );
                }
                if (state is AddSalesErrorState) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sales Banner added Failed')),
                  );
                }
              },
              builder: (context, state) {
                final cubit = context.read<AddSalesCubit>();
                return Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Active Banner
                    const SizedBox(height: 24),

                    // Banner Image
                    Text(
                      'Sales Banner Image',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Recommended size: 1200 × 400 px',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: cubit.pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: cubit.selectedImage == null
                                ? Colors.grey.shade300
                                : AppColors.primaryColor,
                            width: 1.5,
                            style: cubit.selectedImage == null
                                ? BorderStyle.solid
                                : BorderStyle.solid,
                          ),
                        ),
                        child: cubit.selectedImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add_photo_alternate_outlined,
                                    color: AppColors.primaryColor,
                                    size: 42,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Tap to select image',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Choose your sale banner image',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      cubit.selectedImage!,
                                      fit: BoxFit.contain,
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.deleteImage();
                                        },
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.black54,
                                          foregroundColor: Colors.white,
                                        ),
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const SizedBox(height: 30),

                    // Add Button
                    CustomButton(
                      buttonText: 'Add Sales Image',
                      onPressed: () {
                        cubit.addSales();
                      },
                      fontSize: 20,
                    ),

                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
