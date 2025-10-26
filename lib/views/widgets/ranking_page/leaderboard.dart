import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';
import 'package:lodz_trash_bin/views/widgets/ranking_page/leaderboard_list_tile.dart';
import 'package:lodz_trash_bin/views/widgets/ranking_page/top_3_podium.dart';

import 'package:flutter_lucide/flutter_lucide.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({super.key});

  final List<Map<String, dynamic>> leaderboardData = [
    {'rank': 1, 'name': 'Artem Hnap', 'points': 1235},
    {'rank': 2, 'name': 'Mikita Kutsenka', 'points': 1020},
    {'rank': 3, 'name': 'Mikita Dzieviatau', 'points': 975},
    {'rank': 4, 'name': 'Aliaksandr Yurusau', 'points': 850},
    {'rank': 5, 'name': 'Dmytro Malinovskyi', 'points': 810},
    {'rank': 6, 'name': 'Tomasz Lewandowski', 'points': 790},
    {'rank': 7, 'name': 'Joanna Zielińska', 'points': 720},
    {'rank': 8, 'name': 'Michał Szymański', 'points': 680},
    {'rank': 9, 'name': 'Agnieszka Woźniak', 'points': 650},
    {'rank': 10, 'name': 'Paweł Kaczmarek', 'points': 600},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCard(
            outerPadding: EdgeInsetsGeometry.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.trending_up),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      'Najaktywniejsi użytkownicy',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Najwięcej punktów recyklingu',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          CustomCard(
            outerPadding: EdgeInsetsGeometry.symmetric(vertical: 8),
            child: Top3Podium(leaderboardData: leaderboardData.sublist(0, 3)),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: leaderboardData.length,
            itemBuilder: (context, index) {
              final rank = leaderboardData[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: LeaderBoardListTile(
                  points: rank['points'],
                  rank: rank['rank'],
                  name: rank['name'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
