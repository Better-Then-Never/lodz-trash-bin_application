import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';

class LeaderBoardListTile extends StatelessWidget {
  final int rank;
  final String name;
  final int points;

  const LeaderBoardListTile({
    super.key,
    required this.rank,
    required this.name,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    Widget getRankIcon() {
      switch (rank) {
        case 1:
          return Icon(LucideIcons.crown, color: Colors.yellow[700], size: 20);
        case 2:
          return Icon(LucideIcons.medal, color: Colors.grey[400], size: 20);
        case 3:
          return Icon(LucideIcons.medal, color: Colors.amber[700], size: 20);
        default:
          return Text(
            '#$rank',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          );
      }
    }

    Color getTileBg() {
      switch (rank) {
        case 1:
          return Colors.yellow[50]!;
        case 2:
          return Colors.grey[200]!;
        case 3:
          return Colors.amber[100]!;
        default:
          return Colors.white;
      }
    }

    Color getTileOutline() {
      switch (rank) {
        case 1:
          return Colors.yellow;
        case 2:
          return Colors.grey;
        case 3:
          return Colors.amber;
        default:
          return const Color.fromARGB(255, 231, 231, 231);
      }
    }

    return CustomCard(
      outerPadding: EdgeInsetsGeometry.zero,
      padding: EdgeInsets.symmetric(vertical: 8),
      color: getTileBg(),
      borderColor: getTileOutline(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            SizedBox(width: 30, child: Center(child: getRankIcon())),
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue.shade50,
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Rank #$rank',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 245, 245),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$points pts',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
