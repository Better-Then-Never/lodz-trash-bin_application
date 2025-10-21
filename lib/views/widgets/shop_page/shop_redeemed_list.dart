import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/views/widgets/shop_page/shop_redeemed_card.dart';

class ShopRedeemedList extends StatelessWidget {
  final List<Map<String, dynamic>> rewards;

  const ShopRedeemedList({super.key, required this.rewards});

  @override
  Widget build(BuildContext context) {
    if (rewards.isEmpty) {
      return Center(
        child: Text(
          'Nie masz rabatów',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.builder(
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        final reward = rewards[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ShopRedeemedCard(
            title: reward['title'],
            subtitle: reward['subtitle'],
            discountLabel: reward['discountLabel'],
            categoryLabel: reward['categoryLabel'],
          ),
        );
      },
    );
  }
}
