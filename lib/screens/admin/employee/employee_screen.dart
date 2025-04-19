import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/employee_controller.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EmployeeController());
    return const Scaffold();
  }
}
