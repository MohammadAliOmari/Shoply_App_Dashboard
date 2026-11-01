import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_dialog/pro_dialog.dart';
import 'package:shoply_app_dashboard/core/router/app_pages.dart';
import 'package:shoply_app_dashboard/core/utils/images/app_images.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_button.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_dialog.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_loading.dart';
import 'package:shoply_app_dashboard/core/utils/widgets/custom_text_form_field.dart';
import 'package:shoply_app_dashboard/features/login/view_model/cubit.dart';
import 'package:shoply_app_dashboard/features/login/view_model/state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: BlocListener<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoadingState) {
                      CustomLoading.showDialogLoading(context: context);
                    } else if (state is LoginErrorState) {
                      Navigator.pop(context);
                      CustomDialog.showCustomDialog(
                        type: DialogType.error,
                        context: context,
                        title: 'Login Error',
                        description: state.errorMessage,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      );
                    } else if (state is LoginSuccessState) {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppPages.layoutScreen,
                        (route) => false,
                      );
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      final cubit = context.read<LoginCubit>();
                      return Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            Image(
                              image: AssetImage(AppImages.shoplyLogo),
                              color: theme.primaryColor,
                              width: 250,
                              height: 200,
                            ),
                            Text(
                              'Welcom Back',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Sign to Manage Your Shop',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Your Email';
                                }
                                return null;
                              },
                              controller: cubit.emailController,
                              hinText: 'Email',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            SizedBox(height: 5),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your Password';
                                }
                                return null;
                              },
                              controller: cubit.passwordController,
                              hinText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.grey.shade700,
                              ),
                              obscureText: true,
                            ),

                            SizedBox(height: 20),
                            CustomButton(
                              buttonText: 'Login',
                              onPressed: () {
                                cubit.login();
                              },
                              style: TextStyle(
                                fontSize: 25,
                                color: theme.colorScheme.surface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
