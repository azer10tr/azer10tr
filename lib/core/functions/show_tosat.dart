import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

Future<void> showTosat({
  required String title,
  required String description,
  bool isError = false,
  ToastificationStyle? style,
}) async {
  toastification.show(
    context: Get.context,
    title: Text(title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    description: Text(description, style: const TextStyle(fontSize: 14)),
    autoCloseDuration: const Duration(seconds: 5),
    type: isError ? ToastificationType.error : ToastificationType.success,
    style: style ?? ToastificationStyle.fillColored,
  );
}
