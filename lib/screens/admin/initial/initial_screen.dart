import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/initial_controller.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InitialController());
    return const Scaffold();
  }
}
