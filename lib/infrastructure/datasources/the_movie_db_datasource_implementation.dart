import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_data_sources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/themoviedb_response.dart';
import 'package:dio/dio.dart';

class TheMovieDbDatasourceImplementation extends MoviesDataSources{

  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      'api_key': Environment.theMovieDbkey,
      'language': 'es-ES'
    }
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get("/movie/now_playing");
    final theMovieDbResponse = TheMovieDbResponse.fromJson(response.data);

    final List<Movie> movies = theMovieDbResponse.results
    .where((movieDB) => movieDB.posterPath != 'no-poster')
        .map((movieDB) => MovieMapper.theMovieDbToMovie(movieDB)).toList();
    return movies;
  }

}