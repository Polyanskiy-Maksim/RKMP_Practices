import 'package:flutter/material.dart';

import '../widgets/text_field.dart';
import 'profile_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Ключ позволяет проверить все поля формы одной командой.
  final _formKey = GlobalKey<FormState>();
  // Контроллеры дают доступ к введённым значениям.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Освобождаем контроллеры, когда экран закрывается.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    // Если проверка не пройдена, переход к профилю не выполняется.
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ProfilePage(
          fullName: 'Полянский Максим Дмитриевич',
          email: _emailController.text.trim(),
        ),
      ),
    );
  }

  void _openRegister() {
    // Регистрацию открываем поверх экрана входа.
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.account_circle_outlined, size: 68),
                    const SizedBox(height: 20),
                    Text(
                      'Добро пожаловать!',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Войдите в свой аккаунт или создайте новый',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      inputType: InputFieldType.email,
                      labelText: 'Email',
                      hintText: 'name@example.com',
                      controller: _emailController,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      inputType: InputFieldType.password,
                      labelText: 'Пароль',
                      hintText: 'Буква, цифра и символ +, _ или -',
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Для сброса пароля обратитесь к администратору.',
                              ),
                            ),
                          );
                        },
                        child: const Text('Забыли пароль?'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _submit,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Войти'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('Нет аккаунта? '),
                        TextButton(
                          onPressed: _openRegister,
                          child: const Text('Зарегистрируйтесь'),
                        ),
                      ],
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
