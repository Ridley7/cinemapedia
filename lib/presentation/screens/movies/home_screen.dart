
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/views/views_barrel.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = "home-screen";

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

