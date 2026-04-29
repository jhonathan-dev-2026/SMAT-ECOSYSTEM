import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/estacion.dart';

class ApiService {
  // Detecta automáticamente si estás en Chrome (localhost) o Emulador Android
  final String baseUrl = kIsWeb
      ? "http://127.0.0.1:8000"
      : "http://10.0.2.2:8000";
  final String token = "admin_fisi";

  Future<List<Estacion>> fetchEstaciones() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/estaciones/'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Estacion.fromJson(data)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión con el Backend SMAT');
    }
  }

  Future<void> createEstacion(Estacion estacion) async {
    // A. Primero pedimos el token real al servidor
    final authResponse = await http.post(Uri.parse('$baseUrl/token'));
    if (authResponse.statusCode != 200) {
      throw Exception('No se pudo obtener el token de acceso');
    }
    final String realToken = json.decode(authResponse.body)['access_token'];

    // B. Ahora enviamos la estación con el token REAL
    final response = await http.post(
      Uri.parse('$baseUrl/estaciones/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $realToken', // <--- IMPORTANTE: Usar el token real
      },
      body: jsonEncode(estacion.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      debugPrint("Error del server: ${response.body}");
      throw Exception('No se pudo crear: ${response.statusCode}');
    }
  }
}
