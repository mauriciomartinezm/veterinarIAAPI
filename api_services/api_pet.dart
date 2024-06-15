import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../model/pet.dart';

Future<Pet> getPet(int IDMascota) async {
  var url = Uri.parse(
      'http://192.168.10.4:3000/getPet/$IDMascota'); // Cambiado para emulador

  try {
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var petData = responseBody['pet']; // Extract pet object
      print(petData);
      return Pet.fromJson(petData); // Devolver un objeto Pet
    } else {
      throw Exception('Error al obtener la mascota');
    }
  } catch (e) {
    throw Exception('Error de conexión');
  }
}

Future<List<Map<String, dynamic>>> getPets(String cedulaPropietario) async {
  var url = Uri.parse('http://192.168.10.4:3000/getPets/$cedulaPropietario');
  var response =
      await http.get(url, headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    List<dynamic> responseBody = jsonDecode(response.body);
    List<Map<String, dynamic>> petsList =
        List<Map<String, dynamic>>.from(responseBody);
    return petsList;
  } else {
    print('Error en la petición: ${response.statusCode}');
    throw Exception('Error al obtener las mascotas');
  }
}

Future<Map<String, dynamic>> registerPet(String nombre, String cedula) async {
  var url = Uri.parse('http://192.168.10.4:3000/registerPet');
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);

  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'Nombre': nombre,
      'CedulaPropietario': cedula,
      'FIngreso': formattedDate,
    }),
  );
  var responseBody = jsonDecode(response.body);
  print(responseBody);
  // Verificar el estado de la respuesta
  if (response.statusCode == 200) {
    // Deserializar la respuesta JSON
    return responseBody;
  } else if (response.statusCode == 409) {
    return responseBody;
  } else {
    // Manejar el error devolviendo la respuesta JSON con un mensaje de error
    return responseBody;
  }
}

Future<Map<String, dynamic>> updateInf(int IDMascota, String pet) async {
  print(pet);
  var url =
      Uri.parse('http://192.168.10.4:3000/updatePet/$IDMascota'); // Cambiado para emulador
  try {
    // Enviar la solicitud POST con cedula y contrasenia en el cuerpo
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: pet,
    );

    // Verificar el estado de la respuesta
    if (response.statusCode == 200) {
      // Deserializar la respuesta JSON
      var responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      // Manejar el error devolviendo la respuesta JSON con un mensaje de error
      var responseBody = jsonDecode(response.body);
      return responseBody;
    }
  } catch (e) {
    print('Error al hacer la solicitud: $e');
    return {'messageFail': 'Error de conexión'};
  }
}

Future<void> deletePet(int IDMascota) async {
  var url = Uri.parse('http://192.168.10.4:3000/deletePet/$IDMascota');

  try {
    var response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print('Mascota eliminada: $responseBody');
      return responseBody;
    } else {
      print('Error en la petición: ${response.statusCode}');
      var responseBody = jsonDecode(response.body);
      return responseBody;
    }
  } catch (e) {
    print('Error en la solicitud DELETE: $e');
  }
}
