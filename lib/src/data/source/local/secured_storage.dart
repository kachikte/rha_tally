import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rha/src/domain/domain.dart';

class SecuredStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  // final options = IOSOptions(accessibility: IOSAccessibility.first_unlock);

  static Future<void> writeData({required StorageModel storageModel}) async {
    await _storage.write(
        key: storageModel.key,
        value: storageModel.value,
        aOptions: _getAndroidOptions());
  }

  static Future<String?> readData({required String key}) async {
    return await _storage.read(key: key, aOptions: _getAndroidOptions());
  }

  static Future<void> delete({required String key}) async {
    await _storage.delete(key: key, aOptions: _getAndroidOptions());
  }

  static Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key, aOptions: _getAndroidOptions());
  }

  static Future<List<StorageModel>> readAll() async {
    List<StorageModel> storageModels = [];
    Map<String, String> data =
        await _storage.readAll(aOptions: _getAndroidOptions());
    data.entries.map((e) {
      StorageModel storageModel = StorageModel(key: e.key, value: e.value);
      storageModels.add(storageModel);
    });

    return storageModels;
  }

  static Future<void> deleteAll() async {
    await _storage.deleteAll(aOptions: _getAndroidOptions());
  }
}
