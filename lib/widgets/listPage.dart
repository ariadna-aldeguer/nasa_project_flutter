import 'package:flutter/material.dart';
import 'package:project/apiService/ApiService.dart';
import 'package:project/model/apod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detailPage.dart';

class ListPage extends StatefulWidget {
  final String tipo; 
  const ListPage({Key? key, required this.tipo}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Apod>>(
            future: apiService.getList(widget.tipo),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                         ListTile(
                          leading: ElevatedButton(
                             onPressed: () {
                               onClick(
                              snapshot.data![index].date,
                              snapshot.data![index].explanation,
                              snapshot.data![index].title,
                              snapshot.data![index].url,
                              snapshot.data![index].copyright
                            );
                            },
                            child: const Icon(Icons.favorite_border),
                            ),
                          trailing: Image.network(snapshot.data![index].url),
                          title: Text(snapshot.data![index].title),
                          subtitle: Text(snapshot.data![index].explanation),
                        )
                      ]
                    )
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  onClick(String date, String explanation, String title, String url, String copyright){
    print("hola");
    apiService.saveFavorite(date, explanation, title, url, copyright);
  }
}

