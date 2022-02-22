import 'dart:io';

class HttpHelper {
  static Future<bool> isConnected() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty) {
        return true;
      }
    } on Exception {
      return false;
    }

    return false;
  }
}
