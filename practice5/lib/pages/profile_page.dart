import 'package:flutter/material.dart';

import '../widgets/text_field.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.fullName, required this.email});

  final String fullName;
  final String email;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Контроллеры связывают поля профиля с начальными данными.
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Подставляем имя и почту, переданные с предыдущего экрана.
    _nameController.text = widget.fullName;
    _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _save() {
    // Сохраняем форму только после того, как все проверки пройдены.
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Данные профиля сохранены')));
  }

  void _logout() {
    // Очищаем историю экранов, чтобы кнопка «Назад» не вернула в профиль.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Выйти из профиля',
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 6, 24, 12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 42,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      child: Icon(
                        Icons.person,
                        size: 52,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('Данные пользователя'),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      inputType: InputFieldType.fullName,
                      labelText: 'Полное имя',
                      hintText: 'Ваше имя',
                      controller: _nameController,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      inputType: InputFieldType.email,
                      labelText: 'Email',
                      hintText: 'name@example.com',
                      controller: _emailController,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      inputType: InputFieldType.password,
                      labelText: 'Новый пароль',
                      hintText: 'Не менее 6 символов',
                      controller: _passwordController,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      inputType: InputFieldType.confirmPassword,
                      labelText: 'Повторите пароль',
                      hintText: 'Введите пароль ещё раз',
                      controller: _confirmController,
                      confirmController: _passwordController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _save(),
                    ),
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Сохранить'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
