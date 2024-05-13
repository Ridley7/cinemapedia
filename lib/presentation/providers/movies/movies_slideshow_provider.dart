import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {

  final List<Movie> peliculasEnCartelera = ref.watch(nowPlayingProvider);

  if(peliculasEnCartelera.isEmpty) return[];

  return peliculasEnCartelera.sublist(0, 6);

});