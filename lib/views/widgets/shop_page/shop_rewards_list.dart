import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/services/offer_service.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/widgets/shop_page/shop_reward_card.dart';
import 'package:provider/provider.dart';

class ShopRewardsList extends StatelessWidget {
  const ShopRewardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = context.watch<UserService>();
    final allRewards = context.read<OfferService>().offers;

    final redeemedIds = userService.redeemedOfferIds;
    final filteredRewards = allRewards
        .where((r) => !redeemedIds.contains(r['id']))
        .toList();

    if (filteredRewards.isEmpty) {
      return Center(
        child: Text(
          'Wszystkie rabaty zostały zrealizowane',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredRewards.length,
      itemBuilder: (context, index) {
        final reward = filteredRewards[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ShopRewardCard(
            offerId: reward['id'],
            userService: userService,
            title: reward['title'],
            subtitle: reward['subtitle'],
            discountLabel: '${reward['discountInPercents'] ?? 0}%',
            categoryLabel: reward['category'],
            points: reward['pricePoints'],
          ),
        );
      },
    );
  }
}
