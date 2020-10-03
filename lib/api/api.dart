
import 'package:http/http.dart' as http;
import 'package:json_async/json_async.dart';
import 'package:kepler/models/dailyImageData.dart';


class API {
  static const String url = "https://kepler-api-1.herokuapp.com/";
  static const String dailyUrl = "https://api.nasa.gov/planetary/apod?hd=true&api_key=nrXAZMcugA46nocWFcJrgKkDV65dxpYWX1NDoFjj";

  static Future<List> getAllData() async {
    final http.Response response = await http.get(url);
    print("HTTP GET - " + url);
    final List data = await jsonDecodeAsync(response.body);
    return data;
  }

  static Future<DailyImageData> getImageOfTheDay() async{
    final http.Response response = await http.get(dailyUrl);
    print("HTTP GET - " + dailyUrl);
    final Map data = await jsonDecodeAsyncMap(response.body);
    final DailyImageData image = DailyImageData.fromMap(data);
    return image;
  }

}
