class DailyImageData {
  String date;
  String explanation;
  String hdurl;
  String mediaType;
  String serviceVersion;
  String title;
  String url;

  DailyImageData();

  DailyImageData.fromMap(Map<String, dynamic> map) {
    date = map['date'];
    explanation = map['explanation'];
    hdurl = map['hdurl'];
    mediaType = map['media_type'];
    serviceVersion = map['service_version'];
    title = map['title'];
    url = map['url'];
  }
}