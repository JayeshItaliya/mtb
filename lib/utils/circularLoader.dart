import 'dart:async';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';


Timer? _dismissAfter5sTimer;
Timer? _progressTimer;


void loadingDialog() {
  _stopAllTimer();
  SVProgressHUD.show(status: "Loading...");
  _dismissAfter5s();
}

void showSuccessDialog(String message) {
  _stopAllTimer();
  SVProgressHUD.showSuccess(status: message);
}

void showErrorDialog(String error) {
  _stopAllTimer();
  SVProgressHUD.showError(status: error);
}


void _dismissAfter5s() {
  if (_dismissAfter5sTimer != null && _dismissAfter5sTimer!.isActive) {
    _dismissAfter5sTimer!.cancel();
  }

  _dismissAfter5sTimer = Timer(const Duration(milliseconds: 5000), () {
    SVProgressHUD.dismiss();
  });
}
void _stopAllTimer() {
  if (_dismissAfter5sTimer != null && _dismissAfter5sTimer!.isActive) {
    _dismissAfter5sTimer!.cancel();
  }
  if (_progressTimer != null && _progressTimer!.isActive) {
    _progressTimer?.cancel();
  }
}