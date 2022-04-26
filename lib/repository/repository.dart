import 'dart:convert';

import 'package:app_test_1/model/response.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<Response> fetchAlbum() async {
    final response = await http.get(Uri.parse('https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf'));
    return Response.fromJson(jsonDecode(response.body));
  }
}
