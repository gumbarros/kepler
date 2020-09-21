class StarData {
  String name;
  double temperature;
  double radius;


  StarData({this.name, this.temperature, this.radius});

  StarData.fromList(List<String> items) : this(name:items[0], temperature:double.parse(items[1]), radius:double.parse(items[2]));
}
