import 'package:http/http.dart' as http;
import 'package:json_async/json_async.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/models/starData.dart';

class API {
  static const String url =
      "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?";

  static Future<List<PlanetData>> getAllPlanets() async {
    const String url = API.url +
        "table=exoplanets&columns=pl_name,pl_orbper,pl_hostname,pl_bmassj,pl_dens,pl_rads,pl_disc,pl_locale,pl_telescope,pl_status&format=json&where=pl_status=3";
    final http.Response response = await http.get(url);
    print("HTTP GET - " + url);
    final List data = await jsonDecodeAsync(response.body);
    final List<PlanetData> planets =
        data.map((planet) => PlanetData.fromMap(planet)).toList();
    return planets;
  }

  static Future<List<PlanetData>> getPlanetsByName(String name) async {
    final String url = API.url +
        "table=exoplanets&columns=pl_name&format=json&where=pl_status=3%20and%20pl_name%20like%20'%25$name%25'";
    final http.Response response = await http.get(url);
    print("HTTP GET - " + url);
    final List data = await jsonDecodeAsync(response.body);
    final List<PlanetData> planets =
        data.map((planet) => PlanetData.fromMap(planet)).toList();
    return planets;
  }

  static Future<PlanetData> getPlanetByName(String name) async {
    final String url = API.url +
        "table=exoplanets&columns=pl_name,pl_orbper,pl_hostname,pl_bmassj,pl_dens,pl_rads,pl_disc,pl_locale,pl_telescope,pl_status,st_jmk2&format=json&where=pl_status=3%20and%20pl_name%20like%20'$name'";
    final http.Response response = await http.get(url);
    print(response.body);
    print("HTTP GET - " + url);
    final List data = await jsonDecodeAsync(response.body);
    final List<PlanetData> planets =
        data.map((planet) => PlanetData.fromMap(planet)).toList();
    return planets[0];
  }

  static Future<List<PlanetData>> getSolarSystemPlanets(String star) async {
    final String url = API.url +
        "table=exoplanets&columns=pl_name&format=json&where=pl_status=3%20and%20pl_hostname%20like%20'$star'";
    final http.Response response = await http.get(url);
    print("HTTP GET - " + url);
    print(response.body);
    final List data = await jsonDecodeAsync(response.body);
    final List<PlanetData> planets =
        data.map((planet) => PlanetData.fromMap(planet)).toList();
    planets.shuffle();
    return planets;
  }

  static Future<List<StarData>> getAllStars() async {
    const String url = API.url +
        "table=exoplanets&columns=pl_hostname,st_teff,st_rad,st_jmk2&format=json";
    final http.Response response = await http.get(url);
    print("HTTP GET - " + url);
    final List data = await jsonDecodeAsync(response.body);
    final List<StarData> stars = data.map((star) => StarData.fromMap(star)).toList();
    return stars;
  }

  static getTestData() async {
    final http.Response response = await http.get(url +
        "table=exoplanets&columns=st_umbj,st_bmvj,st_vjmic,st_vjmrc,st_jmh2,st_hmk2,st_jmk2,st_bmy,st_m1,st_c1,st_colorn&format=json&where=pl_name like 'Kepler-452 b'");
    final List data = await jsonDecodeAsync(response.body);
    print("data->$data");
    return data;
  }
}
