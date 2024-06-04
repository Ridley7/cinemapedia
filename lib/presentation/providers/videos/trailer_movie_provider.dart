
import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_implementation.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProviderFamily<List<Video>, int> trailerMovieProvider = FutureProvider.family((ref, int movieId){
  final MoviesRepositoryImplementation movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getYoutubeVideosById(movieId);
});
