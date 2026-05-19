sealed class BaseForgetPasswordEvent {
  const BaseForgetPasswordEvent();
}

class ForgetPasswordEvent extends BaseForgetPasswordEvent {
  const ForgetPasswordEvent({required this.userEmail});

  final String userEmail;
}
