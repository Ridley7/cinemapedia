

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final GetMovieCallback callback = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMapNotifier(getMovieCallback: callback);
});

typedef GetMovieCallback = Future<Movie> Function(String id);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>>{
  MovieMapNotifier({required this.getMovieCallback}):super({});

  final GetMovieCallback getMovieCallback;

  Future<void> loadMovie(String movieId) async{

    if(state[movieId] != null) return;
    print("Realizando peticion");

    final Movie movie = await getMovieCallback(movieId);

    state = {...state, movieId: movie};

  }

/*
  {
    '505642': Movie(),
    '505643': Movie(),
    '505645': Movie(),
    '501231': Movie(),
  }
*/

}