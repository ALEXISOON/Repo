import 'package:http/http.dart' as http;
import 'dart:convert';

class MongoService {
  static const String _url =
      'http://tu-servidor.com/api/users'; // Reemplaza con tu URL

  static Future<bool> saveUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error al guardar: $e');
      return false;
    }
  }
}
