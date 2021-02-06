import 'package:kepler/src/models/rover_data.dart';

class MarsData {
  int id;
  int sol;
  String imgSrc;
  CameraData camera;
  String earthDate;

  MarsData.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    sol = json['sol'];
    camera = json['camera'] != null ? new CameraData.fromJson(json['camera']) : null;
    imgSrc = json['img_src'];
    earthDate = json['earth_date'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sol'] = this.sol;
    data['img_src'] = this.imgSrc;
    data['earth_date'] = this.earthDate;
    return data;
  }
}