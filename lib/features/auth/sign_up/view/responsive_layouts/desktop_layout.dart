import '../../bloc/sign_up_bloc.dart';
import '../../bloc/sign_up_event.dart';
import 'package:flutter/material.dart';
import '../../bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../widgets/custom_auth_text_field.dart';
import '../../repository/local/sign_up_local_data.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/widgets/adaptive_layout.dart';
import '../../../../../core/widgets/app_lottie_widget.dart';
import '../../../../../core/constants/app_assets_constants.dart';

class SignUpDesktopLayout extends StatelessWidget {
  const SignUpDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is SignUpSuccess) {
          Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
        }
      },
      builder: (context, state) {
        final bloc = context.read<SignUpBloc>();
        return Form(
          key: bloc.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                SignUpLocalData.kSplashBalance,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 60,
                ),
                color: AppColors.primary(context),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
              Text(
                SignUpLocalData.kSignUpTitle,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 30,
                  ),
                  color: AppColors.primary(context),
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 32,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomAuthTextField(
                        label: SignUpLocalData.kFullName,
                        hintText: SignUpLocalData.kFullNameHint,
                        prefixIcon: SignUpLocalData.kPersonOutline,
                        controller: bloc.nameController,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? SignUpLocalData.kValidatorFullNameMessage
                                    : null,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomAuthTextField(
                        label: SignUpLocalData.kEmail,
                        hintText: SignUpLocalData.kEmailHint,
                        prefixIcon: SignUpLocalData.kEmailOutline,
                        controller: bloc.emailController,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? SignUpLocalData.kValidatorEmailMessage
                                    : null,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomAuthTextField(
                        label: SignUpLocalData.kPassword,
                        hintText: SignUpLocalData.kPasswordHint,
                        prefixIcon: SignUpLocalData.kLockOutline,
                        isPassword: true,
                        controller: bloc.passwordController,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? SignUpLocalData.kValidatorPasswordMessage
                                    : null,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 50,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary(context),
                    foregroundColor: AppColors.primaryForeground(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                  onPressed:
                      state is SignUpLoading
                          ? null
                          : () {
                            if (bloc.formKey.currentState!.validate()) {
                              context.read<SignUpBloc>().add(
                                SignUpSubmitted(
                                  
                                  name: bloc.nameController.text.trim(),
                                  email: bloc.emailController.text.trim(),
                                  password: bloc.passwordController.text,
                                ),
                              );
                            }
                          },
                  child:
                      state is SignUpLoading
                          ? AppLottieWidget(
                            lottiePath: AppAssetsConstants.loadingLottie,
                            height: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 24,
                            ),
                            width: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 24,
                            ),
                          )
                          : Text(
                            SignUpLocalData.kSignUpButton,
                            style: GoogleFonts.cairo(
                              fontSize: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 18,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      SignUpLocalData.kAlreadyHaveAccount,
                      style: GoogleFonts.cairo(
                        color: AppColors.mutedForeground(context),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        SignUpLocalData.kSignIn,
                        style: GoogleFonts.cairo(
                          color: AppColors.primary(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
