import 'package:flutter/material.dart';
import 'package:m_toast/m_toast.dart';

void showMessage(BuildContext context, String message) {
  ShowMToast toast = ShowMToast();
  toast.successToast(
    context,
    message: message,
    alignment: Alignment.center,
    icon: Icons.info_outline,
  );
}
