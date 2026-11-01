import 'package:flutter/material.dart';

// Данные языка передаются с главного экрана на экран описания.
class LanguageInfo {
  const LanguageInfo({
    required this.name,
    required this.description,
    required this.image,
    required this.icon,
  });

  final String name;
  final String description;
  final String image;
  final IconData icon;
}

// Один список используется в галерее и карточках каталога.
const languages = <LanguageInfo>[
  LanguageInfo(
    name: 'Dart',
    description: 'Язык Flutter для мобильных и веб-приложений.',
    image: 'assets/images/dart.png',
    icon: Icons.phone_android,
  ),
  LanguageInfo(
    name: 'Python',
    description: 'Читаемый язык для автоматизации и анализа данных.',
    image: 'assets/images/python.png',
    icon: Icons.terminal,
  ),
  LanguageInfo(
    name: 'Java',
    description: 'Язык для серверных и корпоративных приложений.',
    image: 'assets/images/java.png',
    icon: Icons.dns_outlined,
  ),
  LanguageInfo(
    name: 'C++',
    description: 'Язык для системного и высокопроизводительного ПО.',
    image: 'assets/images/cpp.png',
    icon: Icons.memory_outlined,
  ),
  LanguageInfo(
    name: 'JavaScript',
    description: 'Язык интерактивных веб-страниц и приложений.',
    image: 'assets/images/javascript.png',
    icon: Icons.web_outlined,
  ),
];
