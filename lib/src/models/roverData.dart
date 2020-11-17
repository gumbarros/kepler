

class RoverData {
  int id;
  String name;
  DateTime landingDate;
  DateTime launchDate;
  String status;
  int maxSol;
  DateTime maxDate;
  int totalPhotos;
  List<Cameras> cameras;

  RoverData(
      {this.id,
      this.name,
      this.landingDate,
      this.launchDate,
      this.status,
      this.maxSol,
      this.maxDate,
      this.totalPhotos,
      this.cameras});

  RoverData.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    landingDate = DateTime.parse(json['landing_date']);
    launchDate = DateTime.parse(json['launch_date']);
    status = json['status'];
    maxSol = json['max_sol'];
    maxDate = DateTime.parse(json['max_date']);
    totalPhotos = json['total_photos'];
    if (json['cameras'] != null) {
      cameras = new List<Cameras>();
      json['cameras'].forEach((v) {
        cameras.add(new Cameras.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['landing_date'] = this.landingDate;
    data['launch_date'] = this.launchDate;
    data['status'] = this.status;
    data['max_sol'] = this.maxSol;
    data['max_date'] = this.maxDate;
    data['total_photos'] = this.totalPhotos;
    if (this.cameras != null) {
      data['cameras'] = this.cameras.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cameras {
  int id;
  String name;
  int roverId;
  String fullName;

  Cameras({this.id, this.name, this.roverId, this.fullName});

  Cameras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    roverId = json['rover_id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rover_id'] = this.roverId;
    data['full_name'] = this.fullName;
    return data;
  }
}