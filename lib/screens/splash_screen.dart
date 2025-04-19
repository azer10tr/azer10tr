import 'package:employee_attendance/constants/app_cache.dart';
import 'package:employee_attendance/screens/home_screen.dart';
import 'package:employee_attendance/screens/login_screen.dart';
import 'package:employee_attendance/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin/home/home_admin_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return authService.currentUser == null
        ? const LoginScreen()
        : AppCache().isAdmin()
            ? const HomeAdminScreen()
            : const HomeScreen();
  }
}
