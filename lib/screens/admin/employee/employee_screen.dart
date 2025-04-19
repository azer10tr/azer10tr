import 'package:employee_attendance/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/employee_controller.dart';
import 'widgets/employee_card.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EmployeeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee"),
      ),
      body: GetBuilder<EmployeeController>(
        builder: (controller) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => controller.onRefreshData(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(15),
                    itemCount: controller.employeeList.length,
                    itemBuilder: (context, index) {
                      EmployeeModel employee = controller.employeeList[index];
                      return EmployeeCard(employee: employee);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                  ),
                );
        },
      ),
    );
  }
}
