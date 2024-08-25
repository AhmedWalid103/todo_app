import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/features/application_theme_manager.dart';
import 'package:todo_app/core/features/page_route_names.dart';
import 'package:todo_app/core/features/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/core/services/easyLoading.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
 // easyLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To do',
       theme: ApplicationThemeManager.lightTheme,
       initialRoute: PageRouteNames.initial,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      builder: EasyLoading.init(),
    );
  }
}