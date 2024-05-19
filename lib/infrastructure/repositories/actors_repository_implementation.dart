import 'package:cinemapedia/domain/datasources/actors_data_source.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImplementation extends ActorsRepository{

  final ActorsDataSource dataSource;

  ActorsRepositoryImplementation({required this.dataSource});

  @override
  Future<List<Actor>> getActorsById(String movieId) {
    return dataSource.getActorsById(movieId);
  }



}