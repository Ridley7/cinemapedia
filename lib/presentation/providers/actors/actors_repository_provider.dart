import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource_implementation.dart';
import 'package:cinemapedia/infrastructure/repositories/actors_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImplementation(dataSource: ActorMovieDbDatasourceImplementation());
});