import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';

class SessionInCurrentMonth extends StatelessWidget {
  const SessionInCurrentMonth({super.key, required this.userService});

  final UserService userService;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(LucideIcons.calendar),
              SizedBox(height: 3),
              Text(
                'W tym miesiącu',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                userService.currentMonthSessions.toString(),
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
