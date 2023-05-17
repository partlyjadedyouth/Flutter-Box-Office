import 'package:boxoffice/models/movie_models.dart';
import 'package:boxoffice/services/api_services.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final num id;
  final String title;
  final bool adult;

  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.adult,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieModel> movie;
  static const String imageURL = "https://image.tmdb.org/t/p/w500";

  @override
  void initState() {
    super.initState();
    movie = ApiService.getDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: movie,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '$imageURL/${snapshot.data!.poster}',
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 150,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 1.3,
                                ),
                                child: Text(
                                  snapshot.data!.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                "Ratings: ${snapshot.data!.vote.toStringAsFixed(2)} / 10 ${snapshot.data!.adult ? "& adult" : ''}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    "Genre: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  for (var genre in snapshot.data!.genres)
                                    Text(
                                      "${genre['name']} ",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Storyline",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(snapshot.data!.overview,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
