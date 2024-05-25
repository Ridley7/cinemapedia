import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({required this.currentIndex, super.key});

  final int currentIndex;
  
  void onItemTapped(BuildContext context, int index){
    switch(index){
      case 0:
        context.go('/home/0');
      case 1:
        context.go('/home/1');
      case 2:
        context.go('/home/2');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
          label: 'Inicio'
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline),
            label: 'Categorías'
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.factory_outlined),
            label: 'Favoritos'
        ),
      ],
    );
  }
}
