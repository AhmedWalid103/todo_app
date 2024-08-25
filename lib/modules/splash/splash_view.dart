import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/core/features/page_route_names.dart';
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}
class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2,),()
        {
          Navigator.pushReplacementNamed(context, PageRouteNames.layout);
        }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage("assets/images/splash_background.png"),
    fit: BoxFit.cover,);
  }
}
