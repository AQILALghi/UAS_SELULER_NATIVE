// lib/main.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; 
import 'package:crud_app/auth/login_screen.dart';
import 'package:crud_app/home/home_screen.dart';
import 'package:crud_app/utils/app_router.dart';
import 'package:crud_app/utils/app_styles.dart';
import 'package:crud_app/firebase_options.dart';
import 'package:crud_app/theme_provider.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    AppStyles.setTheme(themeProvider.themeMode == ThemeMode.dark ? AppStyles.darkAppTheme : AppStyles.appTheme);

    return MaterialApp(
      title: 'Flutter App Sederhana',
      theme: AppStyles.appTheme, 
      darkTheme: AppStyles.darkAppTheme, 
      themeMode: themeProvider.themeMode,  
      onGenerateRoute: AppRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}