
import 'movies_provider.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {

  final bool peliculasEnCartelera = ref.watch(nowPlayingProvider).isEmpty;
  final bool peliculasPopulares = ref.watch(popularMoviesProvider).isEmpty;
  final bool peliculasProximas = ref.watch(upcomingMoviesProvider).isEmpty;
  final bool peliculasMejorVotadas = ref.watch(topratedMoviesProvider).isEmpty;

  if( peliculasEnCartelera || peliculasPopulares || peliculasProximas || peliculasMejorVotadas) return true;

  return false;

});