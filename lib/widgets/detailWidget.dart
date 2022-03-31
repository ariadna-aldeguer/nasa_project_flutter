import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_downloader/image_downloader.dart';
class DetailWidget extends StatelessWidget {
  final String title;
  final String copyright;
  final String explanation;
  final String date;
  final String url;

  const DetailWidget(
      this.title, this.copyright, this.explanation, this.date, this.url);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(url), fit: BoxFit.cover)),
              width: double.infinity,
              height: size.height * 0.55,
            ),
            Container(
              margin: const EdgeInsets.only(top: 250),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(title, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(copyright,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text(date,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                log('url: $url');
                                var id = await ImageDownloader.downloadImage(url);
                                if (id == null){
                                  log('data: no va');
                                }
                              },
                              icon: Icon(Icons.download),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: Center(
                            child: Text(explanation,
                                style: const TextStyle(
                                  fontSize: 15,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () async {
                                final uri = Uri.parse(url);
                                final response = await http.get(uri);
                                final bytes = response.bodyBytes;

                                Directory temp = await getTemporaryDirectory();
                                final path = '${temp.path}/image.jpg';
                                File(path).writeAsBytesSync(bytes);

                                await Share.shareFiles([path],
                                    text: title + "\n" + date);
                              },
                              icon: Icon(Icons.share),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
