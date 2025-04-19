import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<CacheService> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => CacheService().init());
}
