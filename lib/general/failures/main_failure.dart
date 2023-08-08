import 'package:freezed_annotation/freezed_annotation.dart';
part 'main_failure.freezed.dart';

@freezed
class MainFailure with _$MainFailure {
  // const factory MainFailure.authFailure() = _AuthFailure;

  const factory MainFailure.noElemet({required String errorMsg}) = _NoElemet;
  const factory MainFailure.userNotSignedIn() = _UserNotSignedIn;

  const factory MainFailure.otpVerificationFaild() = _OtpVerificationFaild;
  const factory MainFailure.logedInFailed() = _LogedInFailed;
  const factory MainFailure.serverFailure() = _ServerFailure;
  const factory MainFailure.documentNotFount() = _DocumentNotFount;
}
