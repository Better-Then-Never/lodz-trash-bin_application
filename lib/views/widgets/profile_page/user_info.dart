import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lodz_trash_bin/services/auth_service.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/pages/auth_page.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.userService});

  final UserService userService;

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    final name = userService.name ?? 'Guest';
    final username = userService.username ?? 'username';
    final avatarUrl =
        'https://cdn1.iconfinder.com/data/icons/user-pictures/100/unknown-512.png';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 40, backgroundImage: NetworkImage(avatarUrl)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '@$username',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.redAccent, size: 28),
          tooltip: 'Logout',
          onPressed: () async {
            await authService.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AuthPage()),
            );
            await userService.logout();
          },
        ),
      ],
    );
  }
}
