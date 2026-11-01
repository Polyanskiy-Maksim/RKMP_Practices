import 'package:flutter/material.dart';

import '../models/language_info.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.language});

  final LanguageInfo language;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.name),
        backgroundColor: const Color(0xFFB7FF62),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      language.image,
                      height: 240,
                      width: 280,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  language.name,
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(language.description),
                const SizedBox(height: 20),
                const Text(
                  'Кратко о языке',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '${language.name} входит в подборку языков, которые применяются '
                  'при создании современных программ и сервисов. Этот экран '
                  'показывает, как передать выбранный объект из карточки в маршрут '
                  'детализации.',
                  style: const TextStyle(height: 1.5),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Вернуться к списку'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
