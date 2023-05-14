import 'dart:convert';

import 'package:boxoffice/models/movie_models.dart';
import 'package:http/http.dart';

class ApiService {
  static const String baseURL = "https://movies-api.nomadcoders.workers.dev";

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> popularMovies = [];
    final url = Uri.parse('$baseURL/popular');
    final response = await get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        popularMovies.add(MovieModel.inHomeScreen(movie));
      }
      return popularMovies;
    } else {
      throw Error();
    }
  }

  static Future<List<MovieModel>> getNowInCinemas() async {
    List<MovieModel> nowInCinemas = [];
    final url = Uri.parse('$baseURL/now-playing');
    final response = await get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        nowInCinemas.add(MovieModel.inHomeScreen(movie));
      }
      return nowInCinemas;
    } else {
      throw Error();
    }
  }

  static Future<List<MovieModel>> getComingSoon() async {
    List<MovieModel> comingSoon = [];
    final url = Uri.parse('$baseURL/coming-soon');
    final response = await get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        comingSoon.add(MovieModel.inHomeScreen(movie));
      }
      return comingSoon;
    } else {
      throw Error();
    }
  }

  static Future<MovieModel> getDetails(num id) async {
    final url = Uri.parse('$baseURL/movie?id=$id');
    final response = await get(url);

    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieModel.inDetailScreen(movie);
    } else {
      throw Error();
    }
  }
}
