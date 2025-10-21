import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/achievements_info.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/my_points_count.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/sessions_in_current_month.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/sessions_in_total.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/user_info.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: UserInfo(userService: userService),
          ),
          MyPointsCount(userService: userService),

          Row(
            children: [
              Expanded(child: SessionsInTotal(userService: userService)),
              Expanded(child: SessionInCurrentMonth(userService: userService)),
            ],
          ),
          AchievementsInfo(),
        ],
      ),
    );
  }
}
