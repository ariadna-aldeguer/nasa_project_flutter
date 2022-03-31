class Apod{
  String copyright;
  String date;
  String explanation;
  String hdurl;
  String mediaType;
  String serviceVersion;
  String title;
  String url;
 
 Apod({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url
 });

// Transofrma el Json en Objecte de dades
 factory Apod.fromJson(Map<String, dynamic> json) {
    return Apod(
      copyright: json["copyright"].toString(),
      date: json["date"].toString(),
      explanation: json["explanation"].toString(),
      hdurl: json["hdurl"].toString(),
      mediaType: json["media_type"].toString(),
      serviceVersion: json["service_version"].toString(),
      title: json["title"].toString(),
      url: json["url"].toString()
    );
  }
}

