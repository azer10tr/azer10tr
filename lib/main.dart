import 'package:employee_attendance/screens/splash_screen.dart';
import 'package:employee_attendance/services/attendance_service.dart';
import 'package:employee_attendance/services/auth_service.dart';
import 'package:employee_attendance/services/chat_service.dart';
import 'package:employee_attendance/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);

  // Initialiser Supabase
  await Supabase.initialize(
      url: 'https://fqkvyusoqjvgwblbfwwe.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZxa3Z5dXNvcWp2Z3dibGJmd3dlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ2NTQ2NzgsImV4cCI6MjA1MDIzMDY3OH0.wCtB5uSlhGTJzGE_1sXNZkX587qZBcI9hXfnO4J11Zc');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => DbService()),
        ChangeNotifierProvider(create: (context) => AttendanceService()),
        Provider<ChatService>(create: (_) => ChatService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee attendance',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
