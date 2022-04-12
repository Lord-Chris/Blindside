abstract class IStorageService {
  Map<String, dynamic>? getMap(String key, {Map<String, dynamic>? def});
  Future<void> setMap(String key, Map<String, dynamic> value);
  Future<void> remove(String key);
}
