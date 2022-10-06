import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int indexOfButton;

  @override
  void initState() {
    indexOfButton = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: indexOfButton,
      showElevation: true,
      curve: Curves.ease,
      iconSize: 25,
      items: [
        BottomNavyBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Home'),
          activeColor:
              indexOfButton == 0 ? Colors.deepOrangeAccent : Colors.grey,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.favorite),
          title: const Text('Favorite'),
          activeColor:
              indexOfButton == 1 ? Colors.deepOrangeAccent : Colors.grey,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.shopping_cart),
          title: const Text('Carts'),
          activeColor:
              indexOfButton == 2 ? Colors.deepOrangeAccent : Colors.grey,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.person),
          title: const Text('Profile'),
          activeColor:
              indexOfButton == 3 ? Colors.deepOrangeAccent : Colors.grey,
        ),
      ],
      onItemSelected: (int value) {
        setState(() {
          indexOfButton = value;
        });
      },
    );
  }
}
