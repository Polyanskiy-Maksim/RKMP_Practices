import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/language_info.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onOpenLanguage});

  final ValueChanged<LanguageInfo> onOpenLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Языки программирования'),
        backgroundColor: const Color(0xFFB7FF62),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          final isDesktopOrWeb =
              kIsWeb ||
              defaultTargetPlatform == TargetPlatform.windows ||
              defaultTargetPlatform == TargetPlatform.macOS ||
              defaultTargetPlatform == TargetPlatform.linux;
          // На широком экране карточки идут в две колонки и получают больше воздуха.
          final verticalGap = isDesktopOrWeb ? 16.0 : 9.0;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      isWide ? 32 : 20,
                      isWide ? 24 : 16,
                      isWide ? 32 : 20,
                      0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Языки программирования',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontFamily: 'NotoSansCustom',
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Подборка языков и короткие описания для знакомства.',
                          ),
                          SizedBox(height: verticalGap),
                          const Text(
                            'Галерея языков',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: verticalGap / 2),
                          SizedBox(
                            height: isWide ? 196 : 154,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: languages.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: isWide ? 16 : 10),
                              itemBuilder: (context, index) {
                                final language = languages[index];
                                return SizedBox(
                                  width: isWide ? 210 : 166,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.asset(
                                                language.image,
                                                fit: BoxFit.contain,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            language.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: verticalGap),
                          const Text(
                            'Выберите язык',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: verticalGap / 2),
                        ],
                      ),
                    ),
                  ),
                  if (isWide)
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(32, 0, 32, isWide ? 20 : 8),
                      sliver: SliverGrid.builder(
                        itemCount: languages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 3.5,
                            ),
                        itemBuilder: (context, index) => _LanguageTile(
                          language: languages[index],
                          onTap: () => onOpenLanguage(languages[index]),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                      sliver: SliverList.builder(
                        itemCount: languages.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: verticalGap),
                          child: _LanguageTile(
                            language: languages[index],
                            onTap: () => onOpenLanguage(languages[index]),
                          ),
                        ),
                      ),
                    ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      isWide ? 32 : 20,
                      0,
                      isWide ? 32 : 20,
                      20,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline, color: Colors.green),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Полянский Максим Дмитриевич · ИКБО-65-23',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.language, required this.onTap});

  final LanguageInfo language;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(language.icon, color: Colors.green.shade700),
        title: Text(language.name),
        subtitle: Text(language.description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
