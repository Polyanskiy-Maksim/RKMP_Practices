// Подключаю виджеты Material и классы оформления Flutter.
import 'package:flutter/material.dart';

// Точка входа: передаю корневой виджет в runApp.
void main() => runApp(const MyApp());

// Корневой виджет не хранит изменяемое состояние.
class MyApp extends StatelessWidget {
  // const-конструктор; key передаётся родительскому классу.
  const MyApp({super.key});

  // Переопределяю метод, объявленный в базовом классе.
  @override
  // build описывает интерфейс; context указывает место в дереве.
  Widget build(BuildContext context) {
    // Создаю оболочку приложения с темой и домашней страницей.
    return MaterialApp(
      // Задаю название приложения для системы.
      title: 'Практическая работа 3',
      // Убираю надпись DEBUG в углу экрана.
      debugShowCheckedModeBanner: false,
      // Настраиваю общую тему приложения.
      theme: ThemeData(
        // Строю цветовую схему на основе зелёного цвета.
        colorSchemeSeed: Colors.green,
        // Устанавливаю белый фон страниц Scaffold.
        scaffoldBackgroundColor: Colors.white,
      ),
      // Главным экраном назначаю LanguagesPage.
      home: const LanguagesPage(),
    );
  }
}

// Экран имеет изменяемое состояние — номер изображения.
class LanguagesPage extends StatefulWidget {
  // Создаю конфигурацию экрана и принимаю необязательный key.
  const LanguagesPage({super.key});

  // Переопределяю метод, объявленный в базовом классе.
  @override
  // Создаю объект State, который будет хранить данные экрана.
  State<LanguagesPage> createState() => _LanguagesPageState();
}

// Здесь хранятся состояние экрана, обработчики и метод build.
class _LanguagesPageState extends State<LanguagesPage> {
  // Неизменяемый список путей; индексы элементов от 0 до 4.
  static const _images = [
    // Первый ресурс — Dart, индекс 0.
    'assets/images/dart.png',
    // Второй ресурс — Python, индекс 1.
    'assets/images/python.png',
    // Третий ресурс — Java, индекс 2.
    'assets/images/java.png',
    // Четвёртый ресурс — C++, индекс 3.
    'assets/images/cpp.png',
    // Пятый ресурс — JavaScript, индекс 4.
    'assets/images/javascript.png',
  ];
  // Названия идут в том же порядке, что и пути к изображениям.
  static const _names = ['Dart', 'Python', 'Java', 'C++', 'JavaScript'];
  // Начальное состояние: показываю ресурс с индексом 0.
  int _currentIndex = 0;

  // Общий обработчик нажатия кнопки и изображения.
  void _nextImage() {
    // Сообщаю Flutter об изменении данных и необходимости build.
    setState(() {
      // После индекса 4 получаю (4 + 1) % 5 = 0: цикл замыкается.
      _currentIndex = (_currentIndex + 1) % _images.length;
    });
  }

  // Переопределяю метод, объявленный в базовом классе.
  @override
  // build описывает интерфейс; context указывает место в дереве.
  Widget build(BuildContext context) {
    // Scaffold задаёт каркас страницы: верхнюю панель и тело.
    return Scaffold(
      // Создаю верхнюю панель приложения.
      appBar: AppBar(
        // Вывожу номер работы на верхней панели.
        title: const Text('Практическая работа 3'),
        // Устанавливаю светло-зелёный фон верхней панели.
        backgroundColor: Colors.lightGreenAccent,
        // Располагаю заголовок панели по центру.
        centerTitle: true,
      ),
      // Разрешаю вертикальную прокрутку на небольшом экране.
      body: SingleChildScrollView(
        // Задаю внешние для содержимого отступы по 24 пикселя.
        padding: const EdgeInsets.all(24),
        // Размещаю основные блоки экрана вертикально.
        child: Column(
          // Растягиваю блоки Column по доступной ширине.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Перечисляю дочерние виджеты в порядке отображения.
          children: [
            // Создаю оформленный блок для текста.
            Container(
              // Добавляю внутренние отступы блока по 16 пикселей.
              padding: const EdgeInsets.all(16),
              // Рисую серую рамку вокруг блока.
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              // Центрирую вложенный заголовок.
              child: const Center(
                // Создаю текстовый виджет.
                child: Text(
                  // Название предметной области из практической работы 2.
                  'Языки программирования',
                  // Центрирую строки текста внутри Text.
                  textAlign: TextAlign.center,
                  // Настраиваю оформление заголовка.
                  style: TextStyle(
                    // Имя семейства точно совпадает с family в pubspec.yaml.
                    fontFamily: 'NotoSansCustom',
                    // Устанавливаю размер текста заголовка.
                    fontSize: 22,
                    // Выбираю начертание 700, подключённое в pubspec.yaml.
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Добавляю вертикальный промежуток высотой 18 пикселей.
            const SizedBox(height: 18),
            // Создаю оформленный блок для текста.
            Container(
              // Добавляю внутренние отступы блока по 16 пикселей.
              padding: const EdgeInsets.all(16),
              // Рисую серую рамку вокруг блока.
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              // Создаю текст, который не зависит от состояния.
              child: const Text(
                // Первая часть описания; соседние строки Dart объединит.
                'Языки программирования используются для записи алгоритмов '
                // Продолжаю описание предметной области.
                'и создания программ. С их помощью разрабатывают мобильные '
                // Завершаю текст описания.
                'приложения, сайты, игры и другие системы.',
                // Размер текста 16; высота строки в 1,5 раза больше размера.
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            // Отделяю описание от строки с картинкой.
            const SizedBox(height: 20),
            // Размещаю изображение и список языков горизонтально.
            Row(
              // Перечисляю дочерние виджеты в порядке отображения.
              children: [
                // Выделяю элементу долю свободной ширины Row.
                Expanded(
                  // Оборачиваю изображение детектором пользовательских жестов.
                  child: GestureDetector(
                    // Ключ позволяет тесту найти область нажатия.
                    key: const Key('imageTap'),
                    // Передаю обработчик без скобок; он выполнится при нажатии.
                    onTap: _nextImage,
                    // Загружаю изображение из ресурсов приложения.
                    child: Image.asset(
                      // Выбираю путь по текущему индексу состояния.
                      _images[_currentIndex],
                      // Ключ для проверки выбранного ресурса в тесте.
                      key: const Key('languageImage'),
                      // Ограничиваю высоту изображения 165 пикселями.
                      height: 165,
                      // Помещаю всю картинку в область, сохраняя пропорции.
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Добавляю горизонтальный промежуток 16 пикселей.
                const SizedBox(width: 16),
                // Отдаю постоянному текстовому блоку долю ширины Row.
                const Expanded(
                  // Создаю текстовый виджет.
                  child: Text(
                    // Вывожу список; символы \n создают переводы строки.
                    '1. Dart\n2. Python\n3. Java\n4. C++\n5. JavaScript',
                    // Оформляю список с увеличенным расстоянием между строками.
                    style: TextStyle(fontSize: 16, height: 1.7),
                  ),
                ),
              ],
            ),
            // Добавляю промежуток перед следующим элементом.
            const SizedBox(height: 10),
            // Выравниваю счётчик изображений по центру.
            Center(
              // Создаю текстовый виджет.
              child: Text(
                // В подписи индекс увеличен на 1 для понятной нумерации.
                'Изображение ${_currentIndex + 1} из ${_images.length}: '
                // Подставляю название языка по текущему индексу.
                '${_names[_currentIndex]}',
                // Ключ счётчика для автоматической проверки интерфейса.
                key: const Key('imageCounter'),
                // Устанавливаю размер подписи 14.
                style: const TextStyle(fontSize: 14),
              ),
            ),
            // Добавляю промежуток перед следующим элементом.
            const SizedBox(height: 10),
            // Создаю кнопку переключения изображения.
            ElevatedButton(
              // Ключ помогает тесту найти кнопку.
              key: const Key('nextButton'),
              // Кнопка вызывает тот же метод, что и нажатие на картинку.
              onPressed: _nextImage,
              // Текст внутри кнопки.
              child: const Text('Следующее изображение'),
            ),
            // Добавляю вертикальный промежуток высотой 18 пикселей.
            const SizedBox(height: 18),
            // Отделяю сведения о студенте горизонтальной линией.
            const Divider(),
            // Оборачиваю нижний блок в виджет отступов.
            const Padding(
              // Добавляю отступы сверху и снизу по 12 пикселей.
              padding: EdgeInsets.symmetric(vertical: 12),
              // Размещаю значок и данные студента в одной строке.
              child: Row(
                // Перечисляю дочерние виджеты в порядке отображения.
                children: [
                  // Использую встроенный значок человека, размер 40.
                  Icon(Icons.person_outline, size: 40, color: Colors.green),
                  // Отделяю значок от имени горизонтальным промежутком.
                  SizedBox(width: 16),
                  // Выделяю элементу долю свободной ширины Row.
                  Expanded(
                    // Создаю текстовый виджет.
                    child: Text(
                      // Вывожу ФИО и группу на двух строках.
                      'Полянский Максим Дмитриевич\nИКБО-65-23',
                      // Размер текста 16; высота строки в 1,5 раза больше размера.
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
