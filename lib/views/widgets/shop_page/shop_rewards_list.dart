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
          final discountValue = reward['discountInPercents'];
          final discountString = discountValue == null
              ? '0%'
              : (discountValue is num
                    ? '${discountValue.toInt()}%'
                    : discountValue.toString().replaceAll(
                            RegExp(r'[^0-9]'),
                            '',
                          ) +
                          '%');
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ShopRewardCard(
              title: reward['title'],
              subtitle: reward['subtitle'],
              discountLabel: discountString,
              categoryLabel: reward['category'],
              points: reward['pricePoints'],
            ),
          );
        },
      ),
    );
  }
}
