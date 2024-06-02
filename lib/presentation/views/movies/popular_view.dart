import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

class PopularView extends ConsumerWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<Movie> popularMovies = ref.watch(popularMoviesProvider);

    if(popularMovies.isEmpty){
      return const Center(child: CircularProgressIndicator(strokeWidth: 2,),);
    }

    return Scaffold(
      body: MovieMasonry(
        loadNextPage: ref.read(popularMoviesProvider.notifier).loadNextPage,
        movies: popularMovies,
      ),
    );
  }
}


/*
class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}

class PopularViewState extends ConsumerState<PopularView> {

  @override
  Widget build(BuildContext context) {

    final List<Movie> popularMovies = ref.watch(popularMoviesProvider);


    if(popularMovies.isEmpty){
      return const Center(child: CircularProgressIndicator(strokeWidth: 2,));
    }

    return Scaffold(
      body:MovieMasonry(
        loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
        movies: popularMovies,
      )
    );
  }
}
*/