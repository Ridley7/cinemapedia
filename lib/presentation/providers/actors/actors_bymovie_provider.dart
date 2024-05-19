import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef GetActorsByMovieCallback = Future<List<Actor>> Function (String movieId);

final actorsBymovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  GetActorsByMovieCallback getActorsByMovieCallback = ref.watch(actorsRepositoryProvider).getActorsById;
  return ActorsByMovieNotifier(getActorsByMovieCallback: getActorsByMovieCallback);
});



class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>>{
  ActorsByMovieNotifier({required this.getActorsByMovieCallback}):super({});

  final GetActorsByMovieCallback getActorsByMovieCallback;

  Future<void> loadActors(String movieId) async{

    if(state[movieId] != null) return;

    final List<Actor> actors = await getActorsByMovieCallback(movieId);

    state = {...state, movieId: actors};

  }
}

/*
  {
    '505642': <Actor>[],
    '505643': <Actor>[],
    '505645': <Actor>[],
    '501231': <Actor>[],
  }
*/