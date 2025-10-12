import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';
import 'package:lodz_trash_bin/views/widgets/profile_page/achievements_info/achievement_badge.dart';

class AchievementsInfo extends StatelessWidget {
  const AchievementsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.medal),
              const SizedBox(width: 10),
              const Text('Osiągnięcia', style: TextStyle(fontSize: 16)),
            ],
          ),
          const Text(
            'Twoje ekologiczne osiągnięcia',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              AchievementBadge(emoji: "🌱", label: "Pierwsze kroki"),
              AchievementBadge(emoji: "⭐", label: "1000 punktów"),
              AchievementBadge(emoji: "🔥", label: "Seria 10 dni"),
              AchievementBadge(emoji: "♻️", label: "Miejski bohater"),
            ],
          ),
        ],
      ),
    );
  }
}
