import 'package:flutter/material.dart';

void main() => runApp(const ProgrammingLanguagesApp());

// Данные одного пункта: название, подпись, картинка и значок.
class LanguageInfo {
  const LanguageInfo(this.name, this.description, this.image, this.icon);

  final String name;
  final String description;
  final String image;
  final IconData icon;
}

// Порядок элементов определяет порядок и галереи, и списка.
const languages = <LanguageInfo>[
  LanguageInfo(
    'Dart',
    'Язык Flutter для мобильных и веб-приложений.',
    'assets/images/dart.png',
    Icons.phone_android,
  ),
  LanguageInfo(
    'Python',
    'Читаемый язык для автоматизации и анализа данных.',
    'assets/images/python.png',
    Icons.terminal,
  ),
  LanguageInfo(
    'Java',
    'Язык для серверных и корпоративных приложений.',
    'assets/images/java.png',
    Icons.dns_outlined,
  ),
  LanguageInfo(
    'C++',
    'Язык для системного и высокопроизводительного ПО.',
    'assets/images/cpp.png',
    Icons.memory_outlined,
  ),
  LanguageInfo(
    'JavaScript',
    'Язык интерактивных веб-страниц и приложений.',
    'assets/images/javascript.png',
    Icons.web_outlined,
  ),
];

class ProgrammingLanguagesApp extends StatelessWidget {
  const ProgrammingLanguagesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа 4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LanguagesPage(),
    );
  }
}

// Состояние хранит выбранную карточку, чтобы подсветить её после нажатия.
class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  int? _selectedIndex;

  void _selectLanguage(int index) {
    setState(() => _selectedIndex = index);

    // ScaffoldMessenger показывает уведомление поверх текущего Scaffold.
    final messenger = ScaffoldMessenger.of(context);
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('Выбран язык: ${languages[index].name}'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Практическая работа 4'),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        // Короткий экран получает компактную галерею и описание.
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 600;
            final galleryHeight = compact ? 126.0 : 184.0;
            final galleryWidth = compact ? 166.0 : 190.0;

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Языки программирования',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'NotoSansCustom',
                      fontSize: compact ? 19 : 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    compact
                        ? 'Пять языков: галерея и список с описаниями.'
                        : 'Языки программирования помогают создавать приложения, '
                              'сайты и системы. Ниже — галерея и список с описаниями.',
                    maxLines: compact ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: compact ? 13 : 15, height: 1.3),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Галерея языков',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: galleryHeight,
                    // Горизонтальный список строит элементы по их индексам.
                    child: ListView.builder(
                      key: const Key('gallery'),
                      scrollDirection: Axis.horizontal,
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final language = languages[index];
                        return SizedBox(
                          key: Key('gallery-item-$index'),
                          width: galleryWidth,
                          child: Card(
                            margin: const EdgeInsets.only(right: 10, bottom: 4),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Expanded(
                                    // ClipRRect действительно обрезает углы картинки.
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: Image.asset(
                                        language.image,
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
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
                  const SizedBox(height: 12),
                  const Text(
                    'Выберите язык',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    // Вертикальный список занимает оставшееся место экрана.
                    child: ListView.builder(
                      key: const Key('language-list'),
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final language = languages[index];
                        return Card(
                          key: Key('language-card-$index'),
                          color: _selectedIndex == index
                              ? const Color(0xFFE9F6E8)
                              : null,
                          child: ListTile(
                            leading: Icon(
                              language.icon,
                              color: Colors.green.shade700,
                            ),
                            title: Text(language.name),
                            subtitle: Text(language.description),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => _selectLanguage(index),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.person_outline, color: Colors.green),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Полянский Максим Дмитриевич · ИКБО-65-23',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
