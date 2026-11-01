import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Освобождаем контроллеры при закрытии экрана.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    // Проверка формы не даёт перейти дальше с некорректным email или паролем.
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    Navigator.pushReplacementNamed(
      context,
      Routes.home,
      arguments: {
        'name': 'Полянский Максим Дмитриевич',
        'email': _emailController.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.account_circle_outlined, size: 72),
                  const SizedBox(height: 14),
                  Text(
                    'Добро пожаловать!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Войдите, чтобы открыть каталог языков',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  CustomTextFormField(
                    inputType: InputFieldType.email,
                    labelText: 'Email',
                    hintText: 'name@example.com',
                    controller: _emailController,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    inputType: InputFieldType.password,
                    labelText: 'Пароль',
                    hintText: 'Буква, цифра и символ +, _ или -',
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _submit,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Войти'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.register),
                    child: const Text('Нет аккаунта? Зарегистрируйтесь'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
