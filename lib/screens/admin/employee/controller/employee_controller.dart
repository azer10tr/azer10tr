import 'dart:developer';

import 'package:get/get.dart';
import '../../../../core/functions/show_tosat.dart';
import '../../../../models/employee_model.dart';
import '../../../../services/db_service.dart';

class EmployeeController extends GetxController {
  bool _isLoading = false;
  final List<EmployeeModel> _employeeList = [];

  // Getters
  bool get isLoading => _isLoading;
  List<EmployeeModel> get employeeList => _employeeList;

  @override
  void onInit() {
    _allData();
    super.onInit();
  }

  Future<void> onRefreshData() async => await _allData();

  Future<void> _allData() async {
    _employeeList.clear();
    _isLoading = true;
    update();
    try {
      DbService().getEmployeesData().then((value) {
        _employeeList.addAll(value);
        _isLoading = false;
        log("Employee List: ${_employeeList.length}");
        update();
      });
    } catch (e) {
      _isLoading = false;
      update();
      showTosat(
          title: "Error", description: "Error in load Data", isError: true);
    }
  }
}
