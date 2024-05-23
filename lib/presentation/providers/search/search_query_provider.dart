
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

typedef SearchMoviesCallback = Future<List<Movie>> Function (String query);

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final SearchMoviesCallback searchMovieCallback = ref.read(movieRepositoryProvider).searchMovies;
  return SearchedMoviesNotifier(searchMoviesCallback: searchMovieCallback, ref: ref);
});


class SearchedMoviesNotifier extends StateNotifier<List<Movie>>{
  SearchedMoviesNotifier({
  required this.searchMoviesCallback,
    required this.ref
  }): super([]);

  final SearchMoviesCallback searchMoviesCallback;
  final Ref ref;

  Future<List<Movie>> searchMoviesByQuery(String query) async{

    final List<Movie> movies = await searchMoviesCallback(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;

    return movies;
  }
}