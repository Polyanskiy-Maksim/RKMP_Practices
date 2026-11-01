import 'package:flutter/material.dart';

import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_shell.dart';
import 'routes.dart';

void main() => runApp(const ProgrammingLanguagesApp());

class ProgrammingLanguagesApp extends StatelessWidget {
  const ProgrammingLanguagesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Языки программирования',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF378A4B)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAF7),
        appBarTheme: const AppBarTheme(centerTitle: true),
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
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      initialRoute: Routes.splash,
      // Для обычных экранов подходят заранее объявленные именованные пути.
      routes: {
        Routes.splash: (_) => const LoadingPage(),
        Routes.login: (_) => const LoginPage(),
        Routes.register: (_) => const RegisterPage(),
      },
      // Профилю нужны данные регистрации, а главной странице — данные пользователя.
      onGenerateRoute: (settings) {
        if (settings.name == Routes.home) {
          final user = settings.arguments as Map<String, String>? ?? const {};
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => HomeShell(
              fullName: user['name'] ?? 'Полянский Максим Дмитриевич',
              email: user['email'] ?? 'maksim@example.ru',
            ),
          );
        }
        return null;
      },
    );
  }
}
