

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '';

typedef MovieCallback = Future<List<Movie>> Function({ int page});

final nowPlayingProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final MovieCallback callback = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: callback);
});


class MoviesNotifier extends StateNotifier<List<Movie>>{
  MoviesNotifier({required this.fetchMoreMovies}): super([]);
  final MovieCallback fetchMoreMovies;


  int currentPage = 0;

  Future<void> loadNextPage() async{
    currentPage++;
    List<Movie> movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies];
  }

}