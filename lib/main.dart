// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
// import 'package:flutterauth/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterauth/pages/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
      ),
      home: const SplashScreen(),
    );
  }
}
