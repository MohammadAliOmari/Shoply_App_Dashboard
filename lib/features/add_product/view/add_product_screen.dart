import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app_dashboard/core/model/categories/request_categories.dart';
import 'package:shoply_app_dashboard/core/utils/theme/app_colors.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_button.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_loading.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_text_form_field.dart';
import 'package:shoply_app_dashboard/features/add_product/view_model/cubit.dart';
import 'package:shoply_app_dashboard/features/add_product/view_model/state.dart';
part 'widgets/category_drob_down.dart';
part 'widgets/section_title.dart';
part 'widgets/istreinding_switch.dart';
part 'widgets/iamge_pick_section.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit()..getCategories(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<AddProductCubit, AddProductState>(
            listener: (context, state) {
              if (state is AddProductSuccessState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added successfully')),
                );
              }
              if (state is AddProductLoadingState) {
                CustomLoading.showDialogLoading(context: context);
              }
              if (state is AddProductErrorState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final cubit = context.read<AddProductCubit>();
              return Form(
                key: cubit.formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 10, 22, 25),
                  children: [
                    IamgePickSection(),
                    const SizedBox(height: 25),
                    sectionTitle('Product Name', required: true),
                    CustomTextFormField(
                      hinText: 'Enter product name',
                      controller: cubit.nameController,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Product name is required'
                          : null,
                    ),

                    const SizedBox(height: 19),

                    sectionTitle('Description ', required: true),
                    CustomTextFormField(
                      hinText: 'write product description',
                      controller: cubit.descriptionController,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Product description is required'
                          : null,
                      maxLines: 4,
                    ),

                    const SizedBox(height: 19),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              sectionTitle('Price', required: true),

                              CustomTextFormField(
                                hinText: '0.00',
                                controller: cubit.priceController,

                                validator: (value) {
                                  final price = double.tryParse(value ?? '');
                                  if (price == null || price <= 0) {
                                    return 'Enter valid price';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(child: CategoryDrobDown()),
                      ],
                    ),

                    const SizedBox(height: 15),

                    IsTreindingSwitch(),

                    const SizedBox(height: 20),

                    CustomButton(
                      height: 52,
                      buttonText: 'Add Product',
                      fontSize: 20,
                      onPressed: () {
                        cubit.addProduct();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
