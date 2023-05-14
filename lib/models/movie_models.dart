class MovieModel {
  final num id, vote;
  final String title, backdrop, poster, overview;
  final bool adult;
  final List<dynamic> genres;

  MovieModel.inHomeScreen(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        backdrop = json['backdrop_path'],
        poster = json['poster_path'],
        overview = json['overview'],
        vote = json['vote_average'],
        adult = json['adult'],
        genres = [];

  MovieModel.inDetailScreen(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        backdrop = json['backdrop_path'],
        poster = json['poster_path'],
        overview = json['overview'],
        vote = json['vote_average'],
        adult = json['adult'],
        genres = json['genres'];
}
