import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/utils.dart';
import 'db_service.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  final DbService _dbService = DbService();

  bool _isLoading = false;
  bool get isLoading => _isLoading ;
  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> registerEmployee(String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;

      if (email.isEmpty || password.isEmpty) {
        throw 'All fields are required';
      }

      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw 'Registration failed: user not returned';
      }
      await _dbService.insertNewUser(email, response.user!.id);

      Utils.showSnackBar("Successfully registered!", context, color: Colors.green);

      // Auto login après inscription
      await loginEmployee(email, password, context);

      Navigator.pop(context); // Retour à l'écran précédent
    } catch (e) {
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
    } finally {
      setIsLoading = false;
    }
  }

  Future<void> loginEmployee(String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;

      if (email.isEmpty || password.isEmpty) {
        throw 'All fields are required';
      }

      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw 'Login failed: user not returned';
      }

      // Optionnel : vérifier qu’il existe dans la table `Employees`
      await _dbService.insertNewUser(email, response.user!.id);
    } catch (e) {
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
    } finally {
      setIsLoading = false;
    }
  }


Future signOut() async {
  await _supabase.auth.signOut();
  notifyListeners();
  }
  User? get currentUser => _supabase.auth.currentUser;
      
      }
