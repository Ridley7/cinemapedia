import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_data_source.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasourceImplementation extends ActorsDataSource{

  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
     'api_key': Environment.theMovieDbkey,
     'language': 'es-ES'
    }
  ));

  @override
  Future<List<Actor>> getActorsById(String movieId) async {

    final response = await dio.get('/movie/$movieId/credits');

    final CreditsResponse creditsResponse = CreditsResponse.fromJson(response.data);

    return creditsResponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();

  }

}