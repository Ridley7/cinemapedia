import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieRating extends StatelessWidget {
  const MovieRating({
    super.key,
    required this.movie,
    required this.textStyles,
  });

  final Movie movie;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
          const SizedBox(width: 3,),
          Text(HumanFormats.number(movie.voteAverage, 1),
            style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),
          )
        ],
      ),
    );
  }
}