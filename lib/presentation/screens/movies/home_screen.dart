
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.childView, super.key});

  static const name = "home-screen";
  final Widget childView;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: childView,
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

