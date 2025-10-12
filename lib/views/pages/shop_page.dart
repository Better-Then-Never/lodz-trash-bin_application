import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/views/widgets/shop_page/shop_my_points_count.dart';
import 'package:lodz_trash_bin/views/widgets/shop_page/shop_rewards_list.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final List<Map<String, dynamic>> rewards = [
    {
      'title': 'Rabat na wypierdolenie',
      'subtitle': '50% Rabat na wypierdolenie z Polski',
      'discountLabel': '50%',
      'categoryLabel': 'Transport',
      'points': 500,
    },
    {
      'title': 'Kubek Eko',
      'subtitle': 'Kubek z recyklingu',
      'discountLabel': '10%',
      'categoryLabel': 'Home',
      'points': 200,
    },
    {
      'title': 'Torba Eko',
      'subtitle': 'Torba na zakupy wielokrotnego użytku',
      'discountLabel': '15%',
      'categoryLabel': 'Shopping',
      'points': 300,
    },
    {
      'title': 'Zestaw Roślin',
      'subtitle': 'Mini zestaw do domowego ogródka',
      'discountLabel': '5%',
      'categoryLabel': 'Garden',
      'points': 400,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sklepik z nagrodami',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Wymień swoje eko-punkty',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                ShopMyPointsCount(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  points: 13,
                ),
              ],
            ),
            SizedBox(height: 16),
            ShopRewardsList(rewards: rewards),
          ],
        ),
      ),
    );
  }
}
