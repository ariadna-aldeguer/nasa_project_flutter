import 'package:flutter/material.dart';
import 'package:project/apiService/ApiService.dart';
import 'package:project/model/apod.dart';
import 'package:project/widgets/detailWidget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Apod>(
            future: apiService.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DetailWidget(
                    snapshot.data!.title,
                    snapshot.data!.copyright,
                    snapshot.data!.explanation,
                    snapshot.data!.date,
                    snapshot.data!.url);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}


//Listado
// class _DetailPageState extends State<DetailPage> {
//   final ApiService apiService = ApiService();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       home: Scaffold(
//         body: Center(
//           child: FutureBuilder<List<Apod>>(
//             future: apiService.getList(),
//             builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (_, index) => Container(
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     padding: EdgeInsets.all(20.0),
//                     decoration: BoxDecoration(
//                       color: Color(0xff97FFFF),
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${snapshot.data![index].title}",
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text("${snapshot.data![index].explanation}"),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

