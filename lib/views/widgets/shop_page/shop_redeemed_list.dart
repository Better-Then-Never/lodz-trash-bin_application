import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/widgets/shop_page/shop_redeemed_card.dart';
import 'package:provider/provider.dart';

class ShopRedeemedList extends StatelessWidget {
  const ShopRedeemedList({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = context.watch<UserService>();
    final redeemedRewards = userService.rewards;

    if (redeemedRewards.isEmpty) {
      return Center(
        child: Text(
          'Nie masz rabatów',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.builder(
      itemCount: redeemedRewards.length,
      itemBuilder: (context, index) {
        final reward = redeemedRewards[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ShopRedeemedCard(
            title: reward['title'],
            subtitle: reward['subtitle'],
            discountLabel: '${reward['discountInPercents'] ?? 0}%',
            categoryLabel: reward['category'],
          ),
        );
      },
    );
  }
}
