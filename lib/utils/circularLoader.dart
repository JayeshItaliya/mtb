import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

loadingDialog() {
  return SVProgressHUD.showProgress(
    0.10,
    status: 'Loading...',

  );
}

showSuccessDialog(String message) {
  return SVProgressHUD.showSuccess(
    status: message,
  );
}

showErrorDialog(String error) {
  return SVProgressHUD.showError(status: error);
}