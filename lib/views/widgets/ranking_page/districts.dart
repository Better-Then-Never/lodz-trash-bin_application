import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';
import 'package:lodz_trash_bin/views/widgets/ranking_page/leaderboard_list_tile.dart';
import 'package:lodz_trash_bin/views/widgets/ranking_page/top_3_podium.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class Districts extends StatelessWidget {
  const Districts({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> districtsData = [
      {'rank': 1, 'name': 'Śródmieście', 'points': 12542},
      {'rank': 2, 'name': 'Bałuty', 'points': 10234},
      {'rank': 3, 'name': 'Widzew', 'points': 9238},
      {'rank': 4, 'name': 'Górna', 'points': 5434},
      {'rank': 5, 'name': 'Polesie', 'points': 4321},
    ];

    final int totalPoints = districtsData
        .map((d) => d['points'] as int)
        .reduce((a, b) => a + b);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCard(
            outerPadding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.map_pin),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      'Dzielnice Łodzi',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Najwięcej punktów według dzielnic',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          CustomCard(
            outerPadding: EdgeInsets.symmetric(vertical: 8),
            child: Top3Podium(leaderboardData: districtsData.sublist(0, 3)),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: districtsData.length,
            itemBuilder: (context, index) {
              final district = districtsData[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: LeaderBoardListTile(
                  points: district['points'],
                  rank: district['rank'],
                  name: district['name'],
                ),
              );
            },
          ),
          CustomCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Łączne punkty w mieście',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        totalPoints.toString(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Icon(LucideIcons.trophy, size: 40, color: Colors.amber[300]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
