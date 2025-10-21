import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';

class MyPointsCount extends StatelessWidget {
  const MyPointsCount({super.key, required this.userService});

  final UserService userService;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.coins),
              const SizedBox(width: 10),
              const Text('Moje punkty', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: userService.pointsBalance.toString(),
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    TextSpan(
                      text: ' punktów',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
