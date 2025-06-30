import 'package:flutter/material.dart';
import 'package:crud_app/auth/login_screen.dart';
import 'package:crud_app/auth/register_screen.dart';
import 'package:crud_app/home/home_screen.dart';
import 'package:crud_app/data/add_edit_data_screen.dart';
import 'package:crud_app/data/data_model.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String addData = '/addData';
  static const String editData = '/editData';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.addData:
        return MaterialPageRoute(builder: (_) => const AddEditDataScreen());
      case AppRoutes.editData:
        final Item? item = settings.arguments as Item?;
        return MaterialPageRoute(builder: (_) => AddEditDataScreen(item: item));
      default:
        return MaterialPageRoute(builder: (_) => const Text('Error: Unknown route'));
    }
  }
}