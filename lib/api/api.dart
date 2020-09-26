import 'package:http/http.dart' as http;
import 'package:json_async/json_async.dart';


class API {
  static const String url = "https://kepler-api-1.herokuapp.com/";

  static Future<List> getAllData() async {
    final http.Response response = await http.get(url);
    print("HTTP GET - " + url);
    final List data = await jsonDecodeAsync(response.body);
    return data;
  }

}
