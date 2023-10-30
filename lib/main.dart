
////////////////////////////////////////


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import 'features/app/splash_screen/splash_screen.dart';
import 'features/user_auth/presentation/pages/calendrer_page.dart';
import 'features/user_auth/presentation/pages/home_page.dart';
import 'features/user_auth/presentation/pages/lever_page.dart';
import 'features/user_auth/presentation/pages/library_page.dart';
import 'features/user_auth/presentation/pages/login_page.dart';
import 'features/user_auth/presentation/pages/menu_page.dart';
import 'features/user_auth/presentation/pages/priere_page.dart';
import 'features/user_auth/presentation/pages/qibla_page.dart';
import 'features/user_auth/presentation/pages/sign_up_page.dart';
import 'dart:io';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyARDYTU5oNHeSHIdtaWbuWBK8vysxOLDXU",
        appId: "1:752846935485:web:28a85cb2371c4c28f16ed4",
        messagingSenderId: "752846935485",
        projectId: "flutter-8dc0a",
      ),
    );
  }

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/menu': (context) => MenuPage(),
        '/lever': (context) => WeatherApp(),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/priere': (context) => PrayerTimeScreen(),
        '/Forqan': (context) => HomeScreen(),
        '/qibla': (context) => QiblahScreen(),
        '/qibla': (context) => IslamicCalendarScreen(),




      },
    );
  }
}

// Define Firebase options for different platforms
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyARDYTU5oNHeSHIdtaWbuWBK8vysxOLDXU",
    appId: "1:752846935485:web:28a85cb2371c4c28f16ed4",
    messagingSenderId: "752846935485",
    projectId: "flutter-8dc0a",
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyARDYTU5oNHeSHIdtaWbuWBK8vysxOLDXU",
    appId: "1:752846935485:web:28a85cb2371c4c28f16ed4",
    messagingSenderId: "752846935485",
    projectId: "flutter-8dc0a",
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyARDYTU5oNHeSHIdtaWbuWBK8vysxOLDXU",
    appId: "1:752846935485:web:28a85cb2371c4c28f16ed4",
    messagingSenderId: "752846935485",
    projectId: "flutter-8dc0a",
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyARDYTU5oNHeSHIdtaWbuWBK8vysxOLDXU",
    appId: "1:752846935485:web:28a85cb2371c4c28f16ed4",
    messagingSenderId: "752846935485",
    projectId: "flutter-8dc0a",
  );
}
