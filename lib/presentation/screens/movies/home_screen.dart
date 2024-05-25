
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/views/views_barrel.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.indexView});

  static const name = "home-screen";
  final int indexView;

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: indexView,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomNavigationBar(currentIndex: indexView,),
    );
  }
}

