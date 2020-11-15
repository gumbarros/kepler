import 'package:http/http.dart' as http;
import 'package:json_async/json_async.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/dailyImageData.dart';
import 'package:kepler/src/models/marsData.dart';
import 'package:kepler/src/models/roverData.dart';
import 'package:kepler/src/utils/keplerUtils.dart';


class API {
  static const String url = "https://kepler-api-1.herokuapp.com/";
  static const String dailyUrl = "https://api.nasa.gov/planetary/apod?api_key=nrXAZMcugA46nocWFcJrgKkDV65dxpYWX1NDoFjj";
  static const String marsUrl = "https://mars-photos.herokuapp.com/api/v1";

  static Future<List> getAllData() async {
    KeplerUtils.syncUpdate(string.text("downloading_nasa"), 0.2);

    print("HTTP GET - " + url);

    final http.Response response = await http.get(url);
    KeplerUtils.syncUpdate(string.text("decoding_nasa"), 0.45);
    final List data = await jsonDecodeAsync(response.body);
    return data;
  }

  static Future<DailyImageData> getImageOfTheDay() async{
    try{

      final http.Response response = await http.get(dailyUrl);
      print("HTTP GET - " + dailyUrl);
      final Map data = await jsonDecodeAsyncMap(response.body);

      final DailyImageData image = DailyImageData.fromMap(data);

      assert(image.url != null);

      return image;

    }
    catch(e){
      //There is a bug in NASA API in Brazil and other countries in this timezone in 23:00~00:00 hours
      final String specialUrl = dailyUrl+ "&date="+DateTime.now().subtract(Duration(days: 1)).toString().substring(0,10);
      final http.Response response = await http.get(specialUrl);
      print("HTTP GET - " + specialUrl);
      final Map data = await jsonDecodeAsyncMap(response.body);
      final DailyImageData image = DailyImageData.fromMap(data);
      return image;
    }
  }

    static Future<List<RoverData>> getMarsRovers() async{
      final http.Response response = await http.get(marsUrl+'/rovers');
      print("HTTP GET - " + marsUrl+'/rovers');
      final Map res = await jsonDecodeAsyncMap(response.body);
      final List data = res.values.first;
      final List<RoverData> rovers = data.map((e) => new RoverData.fromMap(e)).toList();
      return rovers;
    }

    static Future<List<MarsData>> getLatestMarsData(String rover,int page) async{
      final http.Response response = await http.get(marsUrl+'/rovers/$rover/latest_photos?page=$page');
      print("HTTP GET - " + marsUrl+'/rovers/$rover/latest_photos?page=$page');
      final Map res = await jsonDecodeAsyncMap(response.body);
      final List data = res.values.first;
      List<MarsData> mars = [];
      if(res.isNotEmpty) mars = data.map((e) => new MarsData.fromMap(e)).toList();
      return mars;
    }
}