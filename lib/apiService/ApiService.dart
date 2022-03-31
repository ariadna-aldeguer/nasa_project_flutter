import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/model/apod.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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

  // Crida a l'API.
  Future<bool> login(String user, String pass) async {
    print(user);
    print(pass);
    var url = "https://www.sundarabcn.com/flutter/login.php";
    bool isLogin = false;
 
    var response = await http
        .post(Uri.parse(url), body: {'username': user, 'password': pass});
 
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        showToast(jsondata["message"]);
        isLogin = false;
      } else if (jsondata["success"]) {
          showToast(jsondata["message"]);
          isLogin = true;
      }
    } else {
      showToast("Error de connexió");
      isLogin = false;
    }
    return isLogin;
  }

  // Mostra missatge a l'usuari
  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
