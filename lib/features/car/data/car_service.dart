import 'dart:convert';
import 'package:http/http.dart' as http;

class CarService {
  final String apiUrl;
  final String? accessToken;

  CarService(this.apiUrl, [this.accessToken]);

  Future<List<dynamic>> fetchCars() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load cars');
    }
  }

  Future<void> createCar(Map<String, dynamic> carData) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      },
      body: json.encode(carData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create car');
    }
  }

  Future<void> editCar(int id, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      },
      body: json.encode(updatedData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit car');
    }
  }

  Future<void> deleteCar(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
      headers: {
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete car');
    }
  }
}
