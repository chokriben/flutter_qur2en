import 'package:flutter/material.dart';
import 'package:qur2en/features/user_auth/presentation/pages/priere_page.dart';
import 'package:qur2en/features/user_auth/presentation/pages/qibla_page.dart';
import 'package:permission_handler/permission_handler.dart';


import '../../../../main.dart';
import 'calendrer_page.dart';
import 'lever_page.dart';
import 'library_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Islamique'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Nombre de colonnes dans la grille
        children: [
          MenuIcon(
            label: 'Prière',
            assetName: 'assets/priere_icon.png',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PrayerTimeScreen(),
                ),
              );
            },
          ),
          MenuIcon(
            label: 'Qibla',
            assetName: 'assets/qibla_icon.png',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QiblahScreen(),
                ),
              );
            },
          ),
          MenuIcon(
            label: 'Lever/Coucher du Soleil',
            assetName: 'assets/coucher-de-soleil.png',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WeatherApp(),
                ),
              );
            },
          ),
          MenuIcon(
            label: 'Calendrier Islamique',
            assetName: 'assets/calendrier_icon.png',
            onPressed: () {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => IslamicCalendarScreen(),
    ),
    );
            },
          ),
          MenuIcon(
            label: 'Bibliothèque de contenus religieux',
            assetName: 'assets/religieux.png',
            onPressed: () {
               Navigator.of(context).push(
              MaterialPageRoute(
              builder: (context) => HomeScreen(),
             ),
               );
            },
          ),
        ],
      ),
    );
  }
}

class MenuIcon extends StatelessWidget {
  final String label;
  final String assetName;
  final VoidCallback onPressed;

  MenuIcon({
    required this.label,
    required this.assetName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetName, width: 100, height: 100),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
