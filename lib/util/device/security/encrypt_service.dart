import 'package:encrypt/encrypt.dart';

class EncryptService {
  static final key = Key.fromUtf8('16characterkey!');
  static final iv = IV.fromLength(16);
  static final encrypter = Encrypter(AES(key));

  static String encrypt(String encrypt) {
    final encrypted = encrypter.encrypt(encrypt, iv: iv);
    return encrypted.base64;
  }

  static String decrypt(String decrypt) {
    final decrypted = encrypter.decrypt64(decrypt, iv: iv);
    return decrypted;
  }
}
