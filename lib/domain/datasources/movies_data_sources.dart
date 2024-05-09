import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDataSources{

  Future<List<Movie>> getNowPlaying({int page = 1});

}