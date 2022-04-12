import 'package:blindside/ui/constants/_constants.dart';
import 'package:get_storage/get_storage.dart';

import 'i_storage_service.dart';

class StorageService extends IStorageService {
  final storage = GetStorage(AppStrings.appName);

  static Future<StorageService> init() async {
    final storage = StorageService();
    await storage.storage.initStorage;
    return storage;
  }

  @override
  Map<String, dynamic>? getMap(String key, {Map<String, dynamic>? def}) {
    return storage.read<Map<String, dynamic>>(key) ?? def;
  }

  @override
  Future<void> remove(String key) async {
    await storage.remove(key);
  }

  @override
  Future<void> setMap(String key, Map<String, dynamic> value) async {
    await storage.write(key, value);
  }
}
