import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return const Scaffold();
  }
}
