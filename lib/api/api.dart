import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:json_async/json_async.dart';
import 'package:kepler/models/keplerData.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/models/starData.dart';

class API {
  static const String url = "http://3c7bdf17bcfa.ngrok.io";

  static Future<List<PlanetData>> getAllPlanets() async {
    const String url = API.url +
        "table=exoplanets&columns=pl_name,pl_orbper,pl_hostname,pl_bmassj,pl_dens,pl_rads,pl_disc,pl_locale,pl_telescope,pl_status&format=json&where=pl_status=3";
    print("HTTP GET - " + url);
    final http.Response response = await http.get(url);
    final List data = await jsonDecodeAsync(response.body);
    final List<PlanetData> planets =
        data.map((planet) => PlanetData.fromMap(planet)).toList();
    return planets;
  }

  static Future<List> getAllData() async {
    final http.Response response = await http.get(url);
    print("HTTP GET - " + url);
    final List data = await jsonDecodeAsync(response.body);
    return data;
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
    return planets;
  }

}
