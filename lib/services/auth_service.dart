import 'package:employee_attendance/constants/app_cache.dart';
import 'package:employee_attendance/core/functions/show_tosat.dart';
import 'package:employee_attendance/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  final _dbService = DbService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future registerEmployee(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == "" || password == "") {
        throw ("All Fields are required");
      }
      final AuthResponse response =
          await _supabase.auth.signUp(email: email, password: password);
      await _dbService.insertNewUser(email, response.user!.id);
      setIsLoading = false;
      showTosat(title: "Success", description: "Successfully registered!");
      await loginEmployee(email, password, context);
      Navigator.pop(context);
    } catch (e) {
      setIsLoading = false;
      showTosat(
          title: "Error", description: "Error in registration", isError: true);
    }
  }

  Future<void> loginEmployee(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == "" || password == "") {
        throw ("All Fields are required");
      }
      await _supabase.auth.signInWithPassword(email: email, password: password);
      bool isAdmin = await _dbService.getUserRoleData();
      if (isAdmin) {
        AppCache().setIsAdmin(true);
      }
      setIsLoading = false;
    } catch (e) {
      setIsLoading = false;
      showTosat(title: "Error", description: "Error in login", isError: true);
    }
  }

  Future signOut() async {
    await _supabase.auth.signOut();
    AppCache().clearAllCache();
    notifyListeners();
  }

  User? get currentUser => _supabase.auth.currentUser;
}
