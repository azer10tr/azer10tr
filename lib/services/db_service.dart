import 'dart:math';

import 'package:employee_attendance/constants/constants.dart';
import 'package:employee_attendance/models/department_model.dart';
import 'package:employee_attendance/models/leave_request_model.dart';
import 'package:employee_attendance/models/user_models.dart';
import 'package:employee_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? userModel;
  List<DepartmentModel> allDepartments = [];
  int? employeeDepartment;

  String generateRandomEmployeeId() {
    final random = Random();
    const allChars = "STE Tunisienne de Vetements , de Travail Et de Loisirs";
    final randomString =
        List.generate(8, (index) => allChars[random.nextInt(allChars.length)])
            .join();
    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await _supabase.from(Constants.employeeTable).insert({
      'id': id,
      'name': '',
      'email': email,
      'employee_id': generateRandomEmployeeId(),
      'department': null,
    });
  }

  Future<UserModel> getUserData() async {
    final userData = await _supabase
        .from(Constants.employeeTable)
        .select()
        .eq('id', _supabase.auth.currentUser!.id)
        .single();
    userModel = UserModel.fromJson(userData);
    // since this function can be called multiple times, then it will reset the department value
    //that is why we are using condition to assign only at the first time
    employeeDepartment == null
        ? employeeDepartment = userModel?.department
        : null;
    return userModel!;
  }

  Future<void> getAllDepartments() async {
    final List result =
        await _supabase.from(Constants.departmentTable).select();
    allDepartments = result
        .map((department) => DepartmentModel.fromJson(department))
        .toList();
    notifyListeners();
  }

  Future updateProfile(String name, BuildContext context) async {
    await _supabase.from(Constants.employeeTable).update({
      'name': name,
      'department': employeeDepartment,
    }).eq('id', _supabase.auth.currentUser!.id);
    Utils.showSnackBar("Profile Update Successfully", context,
        color: Colors.green);
    notifyListeners();
  }

  Future<void> submitLeaveRequest({
    required DateTime startDate,
    required DateTime endDate,
    required String type,
    String? comments,
    required BuildContext context,
  }) async {
    try {
      await _supabase.from('leave_requests').insert({
        'employee_id': _supabase.auth.currentUser!.id,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'type': type,
        'comments': comments,
      });
      Utils.showSnackBar("Demande envoyée !", context, color: Colors.green);
      notifyListeners();
    } catch (e) {
      Utils.showSnackBar("Erreur : ${e.toString()}", context,
          color: Colors.red);
    }
  }

  Future<List<LeaveRequest>> getEmployeeLeaveRequests(
      {required String status}) async {
    final data = await _supabase
        .from('leave_requests')
        .select()
        .eq('employee_id', _supabase.auth.currentUser!.id)
        .eq("status", status)
        .order('created_at', ascending: false);

    return data.map((lr) => LeaveRequest.fromJson(lr)).toList();
  }

// Récupérer toutes les demandes (pour admin)
  Future<List<LeaveRequest>> getAllLeaveRequests() async {
    final data = await _supabase
        .from('leave_requests')
        .select()
        .order('created_at', ascending: false);

    return data.map<LeaveRequest>((lr) => LeaveRequest.fromJson(lr)).toList();
  }

  // Mettre à jour le statut (admin)
  Future<void> updateLeaveStatus(String requestId, String newStatus) async {
    await _supabase
        .from('leave_requests')
        .update({'status': newStatus}).eq('id', requestId);
    notifyListeners();
  }
}
