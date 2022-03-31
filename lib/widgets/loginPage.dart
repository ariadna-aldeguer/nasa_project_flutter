import 'package:flutter/material.dart';
import 'package:project/widgets/bottomNavigation.dart';
import 'package:project/apiService/ApiService.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final ApiService apiService = ApiService();
  var _user = TextEditingController();
  var _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            child: Stack(
              children: [
                Container( // Degradado
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[Colors.blueAccent, Colors.red])),
                  width: double.infinity,
                  height: 250,
                  child: Image.asset("assets/imatges/moon.png", scale: 5),
                ),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.blueGrey,
                  margin: const EdgeInsets.only(left: 25, right: 25, top: 200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Usuari"),
                          controller: _user,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Contrasenya"),
                          controller: _pass,
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                                child: const Text('Go in ->'),
                                onPressed: () async {
                                  print(_user.text);
                                  bool canLog = await apiService.login(this._user.text, this._pass.text);
                                  print(canLog);
                                  if(canLog){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const BottomNavigation()),
                                    );
                                  } 
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const BottomNavigation()),
                                    );
                                },
                            ),
                          
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}