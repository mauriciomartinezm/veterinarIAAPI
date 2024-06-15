import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<Map<String, dynamic>> getCita(int IDCita) async {
  var url = Uri.parse(
      'http://192.168.10.4:3000/getCita/$IDCita'); // Cambiado para emulador

  try {
    // Enviar la solicitud POST con cedula y contrasenia en el cuerpo
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
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

Future<List<Map<String, dynamic>>> getCitas(String cedulaPropietario) async {
  var url = Uri.parse('http://192.168.10.4:3000/getCitas/$cedulaPropietario');
  var response =
      await http.get(url, headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    List<dynamic> responseBody = jsonDecode(response.body);
    List<Map<String, dynamic>> citasList =
        List<Map<String, dynamic>>.from(responseBody);
    return citasList;
  } else {
    print('Error en la petición: ${response.statusCode}');
    throw Exception('Error al obtener las mascotas');
  }
}

Future<List<Map<String, dynamic>>> getHorarios() async {
  var url = Uri.parse('http://192.168.10.4:3000/getHorarios');
  var response =
      await http.get(url, headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 200) {
    List<dynamic> responseBody = jsonDecode(response.body);
    List<Map<String, dynamic>> horariosList =
        List<Map<String, dynamic>>.from(responseBody);
    return horariosList;
  } else {
    print('Error en la petición: ${response.statusCode}');
    throw Exception('Error al obtener las mascotas');
  }
}

Future<Map<String, dynamic>> registerCita(
    int IDMascota, int? IDHorario, String CedulaPropietario, String motivo) async {
  var url = Uri.parse('http://192.168.10.4:3000/registerCita');
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'IDMascota': IDMascota,
      'IDHorario': IDHorario,
      'CedulaPropietario': CedulaPropietario,
      'Motivo': motivo,
    }),
  );
  var responseBody = jsonDecode(response.body);
  print(responseBody);
  if (response.statusCode == 200) {
    return responseBody;
  } else if (response.statusCode == 409) {
    return responseBody;
  } else {
    // Manejar el error devolviendo la respuesta JSON con un mensaje de error
    return responseBody;
  }
}

Future<Map<String, dynamic>> updateHorario(int IDHorario, String estado) async {
  var url = Uri.parse('http://192.168.10.4:3000/updateHorario/$IDHorario');

  var response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'Estado': estado,
    }),
  );
  var responseBody = jsonDecode(response.body);
  print(responseBody);
  if (response.statusCode == 200) {
    return responseBody;
  } else if (response.statusCode == 409) {
    return responseBody;
  } else {
    // Manejar el error devolviendo la respuesta JSON con un mensaje de error
    return responseBody;
  }
}

Future<void> deleteCita(int IDCita) async {
  var url = Uri.parse('http://192.168.10.4:3000/deleteCita/$IDCita');

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
