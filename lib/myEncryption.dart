import 'package:encrypt/encrypt.dart' as encrypy;

class myEncryption {
  static final key = encrypy.Key.fromLength(32);
  static final iv = encrypy.IV.fromLength(16);
  static final encrypter = encrypy.Encrypter(encrypy.AES(key));

  static EncryptAES(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);

    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);
    return encrypted;
  }

  static DecryptAES(text) {
    final decrypted = encrypter.decrypt(text, iv: iv);

    return decrypted;
  }
}
