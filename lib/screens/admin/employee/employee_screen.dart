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
        title: const Text("List of Employees"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GetBuilder<EmployeeController>(
              builder: (controller) => TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: controller.onSearchChanged,
              ),
            ),
          ),
        ),
      ),
      body: GetBuilder<EmployeeController>(
        builder: (controller) {
          if (controller.isLoading && controller.employeeList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.employeeList.isEmpty) {
            return Center(
              child: Text(
                controller.searchQuery.isEmpty
                    ? 'No employees found'
                    : 'No results for "${controller.searchQuery}"',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.onRefreshData(),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.extentAfter == 0 &&
                    !controller.isLoadingMore) {
                  controller.loadMoreData();
                }
                return false;
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(15),
                itemCount: controller.employeeList.length +
                    (controller.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= controller.employeeList.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  EmployeeModel employee = controller.employeeList[index];
                  return EmployeeCard(employee: employee);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
              ),
            ),
          );
        },
      ),
    );
  }
}
