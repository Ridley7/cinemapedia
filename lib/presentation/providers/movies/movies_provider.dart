

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '';

typedef MovieCallback = Future<List<Movie>> Function({ int page});

//Provider para obtener las peliculas que estan actualmente en cartelera
final nowPlayingProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final MovieCallback callback = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: callback);
});

//Provider para obtener las peliculas populares
final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final MovieCallback callback = ref.watch(movieRepositoryProvider).getPopularMovies;
  return MoviesNotifier(fetchMoreMovies: callback);
});

//Provider para obtener las proximas peliculas
final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final MovieCallback callback = ref.watch(movieRepositoryProvider).getUpcomingMovies;
  return MoviesNotifier(fetchMoreMovies: callback);
});

//Provider para obtener las peliculas mejor votadas
final topratedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final MovieCallback callback = ref.watch(movieRepositoryProvider).getTopratedMovies;
  return MoviesNotifier(fetchMoreMovies: callback);
});


class MoviesNotifier extends StateNotifier<List<Movie>>{
  MoviesNotifier({required this.fetchMoreMovies}): super([]);
  final MovieCallback fetchMoreMovies;

  bool loadingMovies = false;
  int currentPage = 0;

  Future<void> loadNextPage() async{


    if(loadingMovies) return;
    loadingMovies = true;

    currentPage++;
    List<Movie> movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies];
    //Estas ñapas no estan tan mal vistas
    await Future.delayed(const Duration(seconds: 1));

    loadingMovies = false;
  }

}