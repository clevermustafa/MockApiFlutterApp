import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mock_api_flutter_app/modal/film_modal.dart';
class NetworkCall {
  Future<List> getFilms() async{
    final url = Uri.parse(BaseUrl+films);
    final http.Response response  = await http.get(url);
    if(response.statusCode == 200) {
      final decodedResult = jsonDecode(response.body);
      final List result =  decodedResult["results"];
      return result;
    }
    return [];
  }
}

const String BaseUrl = "https://swapi.dev/api/";
const String films = "film";