import 'package:flutter/material.dart';
import '../bloc/forget_password_bloc.dart';
import '../bloc/forget_password_events.dart';
import '../bloc/forget_password_states.dart';
import '../../../../core/utils/app_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../widgets/custom_auth_text_field.dart';
import '../../../../core/widgets/adaptive_layout.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/widgets/app_state_widget.dart';
import '../repository/local/forget_password_local_data.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgetPasswordBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background(context),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 18,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 30,
            ),
            children: [
              Text(
                ForgetPasswordLocalData.kForgetPasswordTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primary(context),
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 25,
                  ),
                ),
              ),
              BlocConsumer<ForgetPasswordBloc, BaseForgetPasswordState>(
                listener: (context, state) {
                  if (state is ForgetPasswordFailedState) {
                    AppUtils.showSnackBar(context, message: state.failure.message);
                  }

                  if (state is ForgetPasswordSuccessState) {
                    Navigator.pop(context);
                    AppUtils.showSuccessSnackBar(
                      context,
                      ForgetPasswordLocalData.kSuccess,
                      ForgetPasswordLocalData.kLinkWasSentToYourEmail,
                    );
                  }
                },
                builder: (context, state) {
                  final bloc = context.read<ForgetPasswordBloc>();
                  if (state is ForgetPasswordFailedState) {
                    return AppStateWidget.serverFailure(
                      message: state.failure.message,
                      onRetry: () => context.read<ForgetPasswordBloc>().add(
                        ForgetPasswordEvent(userEmail: bloc.emailController.text),
                      ),
                    );
                  } else if (state is ForgetPasswordLoadingState) {
                    return const AppStateWidget.loading();
                  } else {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomAuthTextField(
                        onFieldSubmitted:
                            (userEmail) =>
                                context.read<ForgetPasswordBloc>().add(
                                  ForgetPasswordEvent(userEmail: userEmail!),
                                ),
                        controller: bloc.emailController,
                        label: ForgetPasswordLocalData.kEmail,
                        hintText: ForgetPasswordLocalData.kEmailHint,
                        prefixIcon: ForgetPasswordLocalData.kEmailOutline,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? ForgetPasswordLocalData
                                        .kValidatorEmailMessage
                                    : null,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


