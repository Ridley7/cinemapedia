
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_implementation.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProviderFamily<List<Movie>, int> similarMoviesProvider = FutureProvider.family((ref, int movieId){
  final MoviesRepositoryImplementation movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getSimilarMovies(movieId);
});

