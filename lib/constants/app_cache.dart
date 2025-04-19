import 'package:get/get.dart';
import '../core/service/cahce_service.dart';

class AppCache {
  final CacheService _service = Get.find<CacheService>();
  final String _isAdmin = 'IS_ADMIN_KEY';

  // is Admin

  bool get isAdmin => _service.sharedPreferences.getBool(_isAdmin) ?? false;

  Future<void> setIsAdmin(bool value) async {
    await _service.sharedPreferences.setBool(_isAdmin, value);
  }

  // clear all cache
  void clearAllCache() async {
    await _service.sharedPreferences.remove(_isAdmin);
  }
}
