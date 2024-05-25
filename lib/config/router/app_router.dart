import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        return HomeScreen(
            indexView: int.parse(state.pathParameters['page'] ?? '0'));
      },
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              return MovieScreen(
                  movieId: state.pathParameters['id'] ?? 'no-id');
            })
      ]),

  GoRoute(
      path: '/',
    redirect: (BuildContext context, GoRouterState state) => '/home/0'
  )
]);
