import 'dart:convert';

import 'package:project/model/apod.dart';
import 'package:http/http.dart' as http;


class ApiService {
    var url = 'api.nasa.gov';
    var urlExtension = '/planetary/apod';
    final Map<String, String> queryParameters = <String, String>{
      'api_key': '6u8YizBXHawwVvOgDaJXNXJoUoxQ2xTZzxXWC11Y',
    };
    final Map<String, String> queryParametersList = <String, String>{
      'api_key': '6u8YizBXHawwVvOgDaJXNXJoUoxQ2xTZzxXWC11Y',
      'count' : '10'
    };

  // Per no bloquejar el thread principal, utilitzem la classe Future
  Future<Apod> getData() async {
    final api = Uri.https(url, urlExtension, queryParameters);
    print(api);

    final response = await http.get(api);

    if (response.statusCode == 200) {
      return Apod.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Apod>> getList() async {
    final api = Uri.https(url, urlExtension, queryParametersList);
    print(api);
    

    final response = await http.get(api);
    
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Apod>((json) => Apod.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
