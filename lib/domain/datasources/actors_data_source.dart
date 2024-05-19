import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsDataSource{

  Future<List<Actor>> getActorsById(String movieId);

}