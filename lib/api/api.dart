import 'package:http/http.dart' as http;
import 'package:json_async/json_async.dart';
import 'package:kepler/models/planets.dart';

class API {
  static const String url =
      "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?";

  static Future<List<PlanetData>> getAllPlanets() async {
    //Before:&columns=pl_name,pl_orbper,pl_hostname,pl_bmassj,pl_dens,pl_radj,pl_disc,pl_locale,pl_telescope,pl_status
    final http.Response response = await http
        .get(url + "table=exoplanets&columns=pl_name&format=json&where=pl_status=3");
    print("HTTP GET - " +
        url +
        "table=exoplanets&columns=pl_name&format=json&where=pl_status=3");
    final List data = await jsonDecodeAsync(response.body);
    final List<PlanetData> planets =
        data.map((planet) => PlanetData.fromMap(planet)).toList();
    return planets;
  }

  static Future<List<PlanetData>> getPlanetsByName(String name) async {
    final http.Response response = await http.get(url +
        "table=exoplanets&columns=pl_name&format=json&where=pl_status=3 and pl_name like '%25$name%25'");
    final List data = await jsonDecodeAsync(response.body);
    final List<PlanetData> planets =
        data.map((planet) => PlanetData.fromMap(planet)).toList();
    return planets;
  }

  static getTestData() async {
    final http.Response response = await http.get(url +
        "table=exoplanets&columns=st_umbj,st_bmvj,st_vjmic,st_vjmrc,st_jmh2,st_hmk2,st_jmk2,st_bmy,st_m1,st_c1,st_colorn&format=json&where=pl_name like 'Kepler-452 b'");
    print(response.body);
    final List data = await jsonDecodeAsync(response.body);
    print("data->$data");
    return data;
  }
}
