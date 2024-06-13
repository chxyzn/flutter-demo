import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> login(String username, String password) async {
  await Future.delayed(const Duration(seconds: 3));

  if (username == 'one' && password == 'pass') {
    await EncryptedStorage().write('isLoggedIn', 'okay');
    return true;
  }
  return false;
}

class EncryptedStorage {
// Create storage
  final storage = const FlutterSecureStorage();

  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  Future<void> clear() async {
    await storage.deleteAll();
  }
}
