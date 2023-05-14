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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FutureBuilder(
              future: movie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            child: Image.network(
                              '$imageURL/${snapshot.data!.poster}',
                              headers: const {
                                "User-Agent":
                                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data!.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Ratings: ${snapshot.data!.vote} / 10 ${snapshot.data!.adult ? "& adult" : ''}",
                        style: const TextStyle(
                          color: Colors.black,
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
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          for (var genre in snapshot.data!.genres)
                            Text(
                              "${genre['name']} ",
                              style: const TextStyle(
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
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        snapshot.data!.overview,
                      ),
                    ],
                  );
                } else {
                  return const Text("...");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
