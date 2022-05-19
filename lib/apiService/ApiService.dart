import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/model/apod.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<List<Apod>> getList(String tipo) async {
    if(tipo == "list"){
      final api = Uri.https(url, urlExtension, queryParametersList);
      final response = await http.get(api);
      
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Apod>((json) => Apod.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load album');
      }
    } else {
      var url = "https://www.sundarabcn.com/flutter/readData.php?idUser=" + await getId();
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Apod>((json) => Apod.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load album');
      }
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
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('id', jsondata["id"]);
          showToast(jsondata["message"]);
          isLogin = true;
      }
    } else {
      showToast("Error de connexió");
      isLogin = false;
    }
    return isLogin;
  }

  saveFavorite(String date, String explanation, String title, String url, String copyrigth) async{
    var url2 = "http://www.sundarabcn.com/flutter/addData.php";
    var id = await getId();
    var response = await http
        .post(Uri.parse(url2), body: {'idUser': id, 'date': date, 
                                     'explanation': explanation, 'title': title, 
                                     'url': url, 'copyright': copyrigth});
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"] == 1) {
        showToast(jsondata["message"]);
      } else if (jsondata["success"] == 1) {
          showToast(jsondata["message"]);
      }
    } else {
      showToast("Error de connexió");
    }
  }


  getId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('id');
    return id;
  }

  // Mostra missatge a l'usuari
  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
