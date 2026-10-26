import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() => runApp(const ProfileFormsApp());

// Здесь задаются общая тема и первый экран приложения.
class ProfileFormsApp extends StatelessWidget {
  const ProfileFormsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Форма пользователя',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF378A4B)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAF7),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFD9E3D8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFF378A4B), width: 2),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
