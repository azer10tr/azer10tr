import 'dart:async';

import 'package:get/get.dart';
import '../../../../core/functions/show_tosat.dart';
import '../../../../models/employee_model.dart';
import '../../../../services/db_service.dart';

class EmployeeController extends GetxController {
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _page = 0;
  final int _perPage = 10;
  final List<EmployeeModel> _employeeList = [];
  String _searchQuery = '';
  Timer? _searchDebounce;

  // Getters
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  List<EmployeeModel> get employeeList => _employeeList;
  bool get hasMore => _hasMore;
  int get page => _page;
  int get perPage => _perPage;
  String get searchQuery => _searchQuery;

  @override
  void onInit() {
    _loadInitialData();
    super.onInit();
  }

  Future<void> onRefreshData() async {
    _page = 0;
    _hasMore = true;
    _employeeList.clear();
    update();
    await _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    _isLoading = true;
    update();

    try {
      final newEmployees = await DbService().getEmployeesData(
        page: _page,
        perPage: _perPage,
        searchQuery: _searchQuery,
      );

      _employeeList.addAll(newEmployees);
      _hasMore = newEmployees.length == _perPage;
      _page++;
    } catch (e) {
      showTosat(
        title: "Error",
        description: "Error loading data",
        isError: true,
      );
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> loadMoreData() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    update();

    try {
      final newEmployees = await DbService().getEmployeesData(
        page: _page,
        perPage: _perPage,
        searchQuery: _searchQuery,
      );

      if (newEmployees.isNotEmpty) {
        _employeeList.addAll(newEmployees);
        _hasMore = newEmployees.length == _perPage;
        _page++;
      } else {
        _hasMore = false;
      }
    } catch (e) {
      showTosat(
        title: "Error",
        description: "Error loading more data",
        isError: true,
      );
    } finally {
      _isLoadingMore = false;
      update();
    }
  }

  void onSearchChanged(String query) {
    _searchQuery = query.trim();

    // Debounce search to avoid too many requests
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _page = 0;
      _hasMore = true;
      _employeeList.clear();
      update();
      _loadInitialData();
    });
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    super.onClose();
  }
}
