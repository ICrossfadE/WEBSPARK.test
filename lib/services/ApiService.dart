import 'dart:convert';
import 'dart:io';

class ApiService {
  late String _url;

  // Зберігаєму url
  void setUrl(String url) {
    if (isValidUrl(url)) {
      _url = url;
    } else {
      throw Exception('Некоректний URL: $url');
    }
  }

  // Валідуємо
  bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (_) {
      return false;
    }
  }

  Future getData() async {
    final client = HttpClient();

    try {
      final uri = Uri.parse(_url);
      final request = await client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        print('response $responseBody');
        return jsonDecode(responseBody);
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      client.close();
    }
  }
}
