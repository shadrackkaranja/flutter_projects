import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyAccessToken = 'accessToken';
  static const _keyRefreshToken = 'refreshToken';
  static const _keyPassword = 'password';
  static const _keyName = 'name';
  static const _keyEmail = 'email';
  static const _keyUserId = 'userId';

  static Future setAccessToken(String accessToken) async =>
      await _storage.write(key: _keyAccessToken, value: accessToken);

  static Future<String?> getAccessToken() async =>
      await _storage.read(key: _keyAccessToken);

  static Future setRefreshToken(String refreshToken) async =>
      await _storage.write(key: _keyRefreshToken, value: refreshToken);

  static Future<String?> getRefreshToken() async =>
      await _storage.read(key: _keyRefreshToken);

  static Future setPassword(String password) async =>
      await _storage.write(key: _keyPassword, value: password);

  static Future<String?> getPassword() async =>
      await _storage.read(key: _keyPassword);

  static Future setName(String name) async =>
      await _storage.write(key: _keyName, value: name);

  static Future<String?> getName() async => await _storage.read(key: _keyName);

  static Future setEmail(String email) async =>
      await _storage.write(key: _keyEmail, value: email);

  static Future<String?> getEmail() async =>
      await _storage.read(key: _keyEmail);

  static Future setUserId(int userId) async =>
      await _storage.write(key: _keyUserId, value: userId.toString());

  static Future getUserId() async =>
      await _storage.read(key: _keyUserId);
}
