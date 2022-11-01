import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mock_api_flutter_app/modal/film_modal.dart';

class NetworkCall {
  Future<List> getFilms() async {
    final url = Uri.parse(BaseUrl + films);

    final http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResult = jsonDecode(response.body);
      final List result = decodedResult["results"];
      List<FilmModal> listOfFilms =
          result.map((e) => FilmModal.fromJson(e)).toList();
      return listOfFilms;
    }
    return [];
  }

  Future<Map> getFilmDetail(int index) async {
    final url = Uri.parse(BaseUrl + films + "/$index");

    final http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResult = jsonDecode(response.body);
      print(decodedResult);
      return decodedResult;

    }
    return {};
  }
}

const String BaseUrl = "https://swapi.dev/api/";
const String films = "films";
