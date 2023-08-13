import 'dart:convert';

class Base64Helper {
  static String encode(dynamic data) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(data);
    return encoded;
  }

  static String decode(String encoded){
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String decoded = stringToBase64.decode(encoded);
    return decoded;
  }
}
