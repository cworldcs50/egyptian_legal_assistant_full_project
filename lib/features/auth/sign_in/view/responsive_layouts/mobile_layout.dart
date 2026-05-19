import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/constants/app_assets_constants.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/adaptive_layout.dart';
import '../../../../../core/widgets/app_lottie_widget.dart';
import '../../../sign_up/repository/local/sign_up_local_data.dart';
import '../../../widgets/custom_auth_text_field.dart';
import '../../../widgets/custom_social_button.dart';
import '../../bloc/sign_in_bloc.dart';
import '../../bloc/sign_in_event.dart';
import '../../bloc/sign_in_state.dart';
import '../../repository/local/sign_in_data.dart';

/// Mobile layout for the sign-in screen.
class SignInMobileLayout extends StatelessWidget {
  const SignInMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is SignInSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppConstants.homeRoute,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<SignInBloc>();
        return Form(
          key: bloc.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                SignInData.kSplashBalance,
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
                SignInData.kSignIn,
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
              CustomSocialButton(
                onPressed: () {
                  context.read<SignInBloc>().add(
                    const SignInWithGoogleRequested(),
                  );
                },
                iconColor: Colors.red,
                icon: SignInData.kGoogle,
                text: SignInData.kContinueWithGoogle,
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
              CustomSocialButton(
                onPressed: () {
                  context.read<SignInBloc>().add(
                    const SignInWithFacebookRequested(),
                  );
                },
                icon: SignInData.kFacebook,
                iconColor: Colors.blue,
                text: SignInData.kContinueWithFacebook,
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
              ),
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.border(context))),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                    ),
                    child: Text(
                      SignInData.kOr,
                      style: GoogleFonts.cairo(
                        color: AppColors.mutedForeground(context),
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.border(context))),
                ],
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomAuthTextField(
                  label: SignInData.kEmail,
                  hintText: SignInData.kEmailHint,
                  prefixIcon: SignInData.kEmailOutlined,
                  controller: bloc.emailController,
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? SignUpLocalData.kValidatorEmailMessage
                              : null,
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomAuthTextField(
                  isPassword: true,
                  label: SignInData.kPassword,
                  prefixIcon: SignInData.kLockOutline,
                  hintText: SignInData.kPasswordHint,
                  controller: bloc.passwordController,
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? SignUpLocalData.kValidatorPasswordMessage
                              : null,
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed:
                      () async => await Navigator.of(
                        context,
                      ).pushNamed(AppConstants.forgetPassword),
                  child: Text(
                    SignInData.kForgetPassword,
                    style: GoogleFonts.cairo(
                      color: AppColors.primary(context),
                      fontWeight: FontWeight.w600,
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
              SizedBox(
                width: double.infinity,
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 50,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary(context),
                    foregroundColor: Colors.white,
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
                      state is SignInLoading
                          ? null
                          : () {
                            if (bloc.formKey.currentState!.validate()) {
                              context.read<SignInBloc>().add(
                                SignInSubmitted(
                                  name: sl<SharedPreferences>().getString("userName") ?? "",
                                  email: bloc.emailController.text.trim(),
                                  password: bloc.passwordController.text,

                                ),
                              );
                            }
                          },
                  child:
                      state is SignInLoading
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
                            SignInData.kSignInButton,
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
                      SignInData.kDontHaveAccount,
                      style: GoogleFonts.cairo(
                        color: AppColors.mutedForeground(context),
                      ),
                    ),
                    TextButton(
                      onPressed:
                          () async => await Navigator.pushNamed(
                            context,
                            AppConstants.signUpRoute,
                          ),
                      child: Text(
                        SignInData.kSignUp,
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
