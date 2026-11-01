import 'package:flutter/material.dart';

import '../models/language_info.dart';
import '../routes.dart';
import 'detail_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

// Оболочка держит панель навигации, а внутренний Navigator — каталог и детали.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.fullName, required this.email});

  final String fullName;
  final String email;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final _contentNavigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  Route<void> _buildContentRoute(RouteSettings settings) {
    if (settings.name == Routes.detail) {
      final language = settings.arguments! as LanguageInfo;
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => DetailPage(language: language),
      );
    }
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => HomePage(
        onOpenLanguage: (language) {
          // Имя маршрута остаётся тем же, данные выбранной карточки передаются аргументом.
          _contentNavigatorKey.currentState?.pushNamed(
            Routes.detail,
            arguments: language,
          );
        },
      ),
    );
  }

  void _selectTab(int index) {
    if (index == 0) {
      // Кнопка «Главная» из карточки детали возвращает к каталогу.
      _contentNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
    setState(() => _selectedIndex = index);
  }

  void _logout() {
    // Очищаем историю и возвращаем пользователя к форме входа.
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            Navigator(
              key: _contentNavigatorKey,
              initialRoute: Routes.homeContent,
              onGenerateRoute: _buildContentRoute,
            ),
            ProfilePage(
              fullName: widget.fullName,
              email: widget.email,
              onLogout: _logout,
            ),
          ],
        ),
      ),
      // NavigationBar меняет вкладку, но сам не управляет маршрутами.
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
