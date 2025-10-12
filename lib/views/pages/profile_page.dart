import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/achievements_info.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/my_points_count.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/sessions_in_current_month.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/sessions_in_total.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/user_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const UserInfo(),
          ),
          const MyPointsCount(),

          Row(
            children: [
              Expanded(child: const SessionsInTotal()),
              Expanded(child: const SessionInCurrentMonth()),
            ],
          ),
          AchievementsInfo(),
        ],
      ),
    );
  }
}
