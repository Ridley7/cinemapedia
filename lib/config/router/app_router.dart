import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:cinemapedia/presentation/views/movies/favorites_view.dart';
import 'package:cinemapedia/presentation/views/movies/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [

  ShellRoute(
    builder: (BuildContext context, GoRouterState state, Widget child){
      return HomeScreen(childView: child);
    },
    routes: [
      GoRoute(
          path: '/',
        builder: (BuildContext context, GoRouterState state){
            return const HomeView();
        },
        routes: [
          GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state){
                return MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id');
              }
          )
        ]
      ),

      GoRoute(
          path: '/favorites',
          builder: (BuildContext context, GoRouterState state){
            return const FavoritesView();
          }
      ),


    ]
  )

  /*
  GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    routes: [
      GoRoute(
          path: 'movie/:id',
        name: MovieScreen.name,
        builder: (context, state){
            return MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id');
        }
      )
    ]
  ),
   */

]);
