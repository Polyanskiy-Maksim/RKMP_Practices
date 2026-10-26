import 'package:flutter/material.dart';

enum InputFieldType { fullName, email, password, confirmPassword }

// Один виджет используется для имени, почты, пароля и его подтверждения.
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.confirmController,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextEditingController? confirmController;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  // Пароль скрыт при открытии формы.
  bool _hidePassword = true;

  bool get _isPassword =>
      widget.inputType == InputFieldType.password ||
      widget.inputType == InputFieldType.confirmPassword;

  IconData get _prefixIcon => switch (widget.inputType) {
    InputFieldType.fullName => Icons.person_outline,
    InputFieldType.email => Icons.mail_outline,
    InputFieldType.password ||
    InputFieldType.confirmPassword => Icons.lock_outline,
  };

  String? _validate(String? input) {
    // trim убирает случайные пробелы по краям перед проверкой.
    final value = input?.trim() ?? '';
    if (value.isEmpty) return 'Заполните это поле';

    switch (widget.inputType) {
      case InputFieldType.fullName:
        if (!RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$').hasMatch(value)) {
          return 'Введите имя буквами, без цифр и знаков';
        }
        break;
      case InputFieldType.email:
        // Проверяем адрес с частью до @ и доменом после него.
        if (!RegExp(
          r'^[A-Z0-9._%+-]+@(?:[A-Z0-9](?:[A-Z0-9-]*[A-Z0-9])?\.)+[A-Z]{2,}$',
          caseSensitive: false,
        ).hasMatch(value)) {
          return 'Проверьте адрес, например name@mail.ru';
        }
        break;
      case InputFieldType.password:
        // Пароль должен содержать букву, цифру и один из заданных символов.
        final validPassword =
            value.length >= 6 &&
            RegExp(r'[A-Za-zА-Яа-яЁё]').hasMatch(value) &&
            RegExp(r'\d').hasMatch(value) &&
            RegExp(r'[+_-]').hasMatch(value);
        if (!validPassword) {
          return 'Нужно 6+ знаков: буква, цифра и символ +, _ или -';
        }
        break;
      case InputFieldType.confirmPassword:
        // Сравниваем подтверждение с исходным паролем.
        if (value != widget.confirmController?.text.trim()) {
          return 'Пароли не совпадают';
        }
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: _validate,
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      obscureText: _isPassword && _hidePassword,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: Icon(_prefixIcon),
        suffixIcon: _isPassword
            ? IconButton(
                // Кнопка справа переключает видимость пароля.
                tooltip: _hidePassword ? 'Показать пароль' : 'Скрыть пароль',
                onPressed: () => setState(() => _hidePassword = !_hidePassword),
                icon: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}
