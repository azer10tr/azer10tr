import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../dummy/index.dart';
import '../../../../models/bottom_navigation_model.dart';
import '../../../leave_list_screen.dart';
import '../../employee/employee_screen.dart';
import '../../initial/initial_screen.dart';

class HomeAdminController extends GetxController {
  int _currentPage = 0;
  final List<Widget> _pages = const [
    InitialScreen(),
    EmployeeScreen(),
    EmployeeLeaveListScreen(),
    EmployeeLeaveListScreen(),
  ];
  final List<BottomNavigationModel> _bottomNavigations = bottomNavigationData;

  // Getters
  int get currentPage => _currentPage;
  List<Widget> get pages => _pages;
  List<BottomNavigationModel> get bottomNavigations => _bottomNavigations;

  void onPageChanged(int index) {
    _currentPage = index;
    update();
  }
}
