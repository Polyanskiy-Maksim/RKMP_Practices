import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.fullName,
    required this.email,
    required this.onLogout,
  });

  final String fullName;
  final String email;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 54,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Профиль пользователя',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 18),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.badge_outlined),
                    title: Text(fullName),
                    subtitle: const Text('ФИО'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.alternate_email),
                    title: Text(email),
                    subtitle: const Text('Электронная почта'),
                  ),
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.school_outlined),
                    title: Text('ИКБО-65-23'),
                    subtitle: Text('Учебная группа'),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: onLogout,
                  icon: const Icon(Icons.logout),
                  label: const Text('Выйти из аккаунта'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
