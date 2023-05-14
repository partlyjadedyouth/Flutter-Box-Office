import 'package:boxoffice/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final num id;
  final String title, backdrop;
  final bool adult;
  static const String imageURL = "https://image.tmdb.org/t/p/w500";

  const MovieCard({
    super.key,
    required this.id,
    required this.title,
    required this.backdrop,
    required this.adult,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(id: id, title: title, adult: adult),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 200,
            height: 100,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(
              '$imageURL/$backdrop',
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
