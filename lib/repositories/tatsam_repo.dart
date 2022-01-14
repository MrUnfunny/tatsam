import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:tatsam/models/country.dart';
import 'package:http/http.dart' as http;

class TatsamRepo {
  static Future<List<Country>> loadAllCountries() async {
    List<Country> _countries = [];
    List<String> shortNames = [];
    List<Country> favoriteCountries = [];

    final response =
        await http.get(Uri.parse('https://api.first.org/data/v1/countries'));
    final Map<String, dynamic> json = jsonDecode(response.body);
    final data = json['data'];

    data.keys.forEach((e) => shortNames.add(e));
    favoriteCountries = getAllFavorites();

    for (var e in shortNames) {
      _countries.add(Country.fromMap(data[e]));
      _countries.last.short = e;
      if (favoriteCountries.any((element) => element.short == e)) {
        _countries.last.favorite = true;
      }
    }
    return _countries;
  }

  static List<Country> getAllFavorites() {
    List<Country> _favCountries = [];
    var box = Hive.box('countries');

    var a = box.toMap();

    a.forEach((key, value) {
      var val = Map<String, dynamic>.from(value);

      _favCountries.add(Country.fromMap(val));
      _favCountries.last.short = key;
    });

    return _favCountries;
  }

  static Future<void> addToFavorites(Country country) async {
    var box = Hive.box('countries');

    await box.put(country.short, country.toMap());
  }

  static Future<void> removeFromFavorites(Country country) async {
    var box = Hive.box('countries');

    await box.delete(country.short);
  }

  static Future<void> removeAllFromFavorites() async {
    var box = Hive.box('countries');

    await box.clear();
  }
}
