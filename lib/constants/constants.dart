import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  Constants._();
  // App Name
  static const String appName = "Employee attendance";
  // Tables
  static const employeeTable = "Employees";
  static const departmentTable = "departments";
  static const attendanceTable = "attendance";
  static const leaveRequestsTable = "leave_requests";
  // Keys
  static String supbaseUrl = dotenv.get('SUPABASE_URL');
  static String supbaseKey = dotenv.get('SUPABASE_KEY');
}
