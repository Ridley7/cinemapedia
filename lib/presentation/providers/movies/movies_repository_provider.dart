
import 'package:cinemapedia/infrastructure/datasources/the_movie_db_datasource_implementation.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImplementation(TheMovieDbDatasourceImplementation());
});