import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/features/page_route_names.dart';
import 'package:todo_app/modules/account/account.dart';
import 'package:todo_app/modules/layout/layout_view.dart';
import 'package:todo_app/modules/menu/menu_view.dart';
import 'package:todo_app/modules/splash/splash_view.dart';

import '../../modules/registration/registration.dart';

class RouteGenerator{

static Route<dynamic> onGenerateRoute(RouteSettings settings)
  {
    switch(settings.name)
    {
      case PageRouteNames.initial :
        {
          return MaterialPageRoute(
              builder:(context)=>const SplashView(),
              settings: settings);
        }
      case PageRouteNames.layout :
        {
          return MaterialPageRoute(
              builder:(context)=> LayoutView(),
              settings: settings);
        }
      case PageRouteNames.registration :
        {
          return MaterialPageRoute(
              builder:(context)=>const RegistrationView(),
              settings: settings);
        }
      case PageRouteNames.account:
        {
          return MaterialPageRoute(
              builder:(context)=> AccountView(),
              settings: settings);
        }
      case PageRouteNames.menu :
        {
          return MaterialPageRoute(
              builder:(context)=>const MenuView(),
              settings: settings);
        }
      default:{
        return MaterialPageRoute(
            builder:(context)=>const SplashView(),
            settings: settings);
      }


    }
  }

}

