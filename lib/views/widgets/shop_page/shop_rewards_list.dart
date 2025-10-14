import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/views/widgets/shop_page/shop_reward_card.dart';

class ShopRewardsList extends StatelessWidget {
  final List<Map<String, dynamic>> rewards;

  const ShopRewardsList({super.key, required this.rewards});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ShopRewardCard(
              title: reward['title'],
              subtitle: reward['subtitle'],
              discountLabel: reward['discountLabel'],
              categoryLabel: reward['categoryLabel'],
              points: reward['points'],
            ),
          );
        },
      ),
    );
  }
}
