import 'package:http/http.dart' as http;
import 'package:json_async/json_async.dart';
import 'package:get/get.dart';
import 'package:kepler/src/models/daily_image_data.dart';
import 'package:kepler/src/models/mars_data.dart';
import 'package:kepler/src/models/rover_data.dart';
import 'package:kepler/src/utils/kepler_utils.dart';

class API {
  static const String url = "https://kepler-api-1.herokuapp.com/";
  static const String dailyUrl =
      "https://api.nasa.gov/planetary/apod?api_key=nrXAZMcugA46nocWFcJrgKkDV65dxpYWX1NDoFjj";
  static const String marsUrl = "https://mars-photos.herokuapp.com/api/v1";

  static Future<List> getAllData() async {
    KeplerUtils.syncUpdate("downloading_nasa".tr, 0.2);

    print("HTTP GET - " + url);

    final http.Response response = await http.get(url);
    KeplerUtils.syncUpdate("decoding_nasa".tr, 0.45);
    final List data = await jsonDecodeAsync(response.body);
    return data;
  }

  static Future<DailyImageData> getImageOfTheDay() async {
    try {
      final http.Response response = await http.get(dailyUrl);
      print("HTTP GET - " + dailyUrl);
      final Map data = await jsonDecodeAsyncMap(response.body);

      final DailyImageData image = DailyImageData.fromMap(data);

      assert(image.url != null);

      return image;
    } catch (e) {
      //There is a bug in NASA API in Brazil and other countries in this timezone in 23:00~00:00 hours
      final String specialUrl = dailyUrl +
          "&date=" +
          DateTime.now()
              .subtract(Duration(days: 1))
              .toString()
              .substring(0, 10);
      final http.Response response = await http.get(specialUrl);
      print("HTTP GET - " + specialUrl);
      final Map data = await jsonDecodeAsyncMap(response.body);
      final DailyImageData image = DailyImageData.fromMap(data);
      return image;
    }
  }

  static Future<List<RoverData>> getMarsRovers() async {
    final http.Response response = await http.get(marsUrl + '/rovers');
    print("HTTP GET - " + marsUrl + '/rovers');
    final Map res = await jsonDecodeAsyncMap(response.body);
    final List data = res.values.first;
    final List<RoverData> rovers =
        data.map((e) => new RoverData.fromMap(e)).toList();
    return rovers;
  }

  static Future<List<MarsData>> getLatestMarsImages(
      String rover, int page) async {
    final http.Response response =
        await http.get(marsUrl + '/rovers/$rover/latest_photos?page=$page');
    print("HTTP GET - " + marsUrl + '/rovers/$rover/latest_photos?page=$page');
    final Map res = await jsonDecodeAsyncMap(response.body);
    final List data = res.values.first;
    List<MarsData> mars = [];
    if (res.isNotEmpty)
      mars = data.map((e) => new MarsData.fromMap(e)).toList();
    return mars;
  }

  static Future<List<MarsData>> getMarsImagesBySol(
      String rover, int page, String sol) async {
    final http.Response response = await http
        .get(marsUrl + '/rovers/$rover/photos?page=$page&sol=$sol');
    print("HTTP GET - " + marsUrl + '/rovers/$rover/photos??page=$page&sol=$sol');
    final Map res = await jsonDecodeAsyncMap(response.body);
    final List data = res.values.first;
    List<MarsData> mars = [];
    if (res.isNotEmpty)
      mars = data.map((e) => new MarsData.fromMap(e)).toList();
    return mars;
  }

  static Future<List<MarsData>> getMarsImagesByEarthDate(
      String rover, int page, String date) async {
    final http.Response response = await http.get(
        marsUrl + '/rovers/$rover/photos?page=$page&earth_date=$date');
    print("HTTP GET - " + marsUrl +'/rovers/$rover/photos?page=$page&earth_date=$date');
    final Map res = await jsonDecodeAsyncMap(response.body);
    final List data = res.values.first;
    List<MarsData> mars = [];
    if (res.isNotEmpty)
      mars = data.map((e) => new MarsData.fromMap(e)).toList();
    return mars;
  }
}
