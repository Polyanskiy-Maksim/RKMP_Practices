import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LanguagesPage(),
    );
  }
}

class LanguagesPage extends StatelessWidget {
  const LanguagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Практическая работа 2'),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: const Center(
                child: Text(
                  'Языки программирования',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: const Text(
                'Языки программирования используются для записи алгоритмов '
                'и создания программ. С их помощью разрабатывают мобильные '
                'приложения, сайты, игры и другие системы.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/programming.png',
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Text(
                    '1. Dart\n2. Python\n3. Java\n4. C++',
                    style: TextStyle(fontSize: 18, height: 1.8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Icon(Icons.person_outline, size: 40, color: Colors.green),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Полянский Максим Дмитриевич\nИКБО-65-23',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
