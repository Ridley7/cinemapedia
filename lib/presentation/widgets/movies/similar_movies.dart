import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/similar_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimilarMovies extends ConsumerWidget {
  const SimilarMovies({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final similiarMovies = ref.watch(similarMoviesProvider(movieId));

    return similiarMovies.when(
        data: (movies) => _Recommendations(movies: movies,),
        error: (_, __) => const Center(child: Text('No se pudo cargar peliculas similar'),),
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2,),)
    );

    return const Placeholder();
  }
}

class _Recommendations extends StatelessWidget {
  const _Recommendations({
    super.key,
    required this.movies
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if(movies.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: MovieHorizontalListview(
        title: 'Recomendaciones',
        movies: movies,
      ),
    );
  }
}
