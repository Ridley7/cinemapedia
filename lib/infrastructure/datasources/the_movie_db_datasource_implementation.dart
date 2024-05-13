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

    final response = await dio.get("/movie/now_playing",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {

    final response = await dio.get("/movie/popular",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopratedMovies({int page = 1}) async {

    final response = await dio.get("/movie/top_rated",
        queryParameters: {
          'page': page
        });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) async{
    final response = await dio.get("/movie/upcoming",
        queryParameters: {
          'page': page
        });

    return _jsonToMovies(response.data);
  }

  List<Movie> _jsonToMovies(Map<String, dynamic> json){

    final theMovieDbResponse = TheMovieDbResponse.fromJson(json);

    final List<Movie> movies = theMovieDbResponse.results
        .where((movieDB) => movieDB.posterPath != 'no-poster')
        .map((movieDB) => MovieMapper.theMovieDbToMovie(movieDB)).toList();
    return movies;

  }

}