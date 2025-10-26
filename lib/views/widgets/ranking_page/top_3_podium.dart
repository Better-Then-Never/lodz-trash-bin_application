import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class Top3Podium extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboardData;

  const Top3Podium({super.key, required this.leaderboardData});

  @override
  Widget build(BuildContext context) {
    Widget getRankIcon(int rank) {
      switch (rank) {
        case 1:
          return Icon(LucideIcons.crown, color: Colors.yellow[700], size: 24);
        case 2:
          return Icon(LucideIcons.medal, color: Colors.grey[400], size: 24);
        case 3:
          return Icon(LucideIcons.medal, color: Colors.amber[700], size: 24);
        default:
          return Text('#$rank');
      }
    }

    Color getBgColor(int rank) {
      switch (rank) {
        case 1:
          return Colors.yellow[500]!.withAlpha(100);
        case 2:
          return Colors.grey[400]!.withAlpha(100);
        case 3:
          return Colors.amber[700]!.withAlpha(100);
        default:
          return Colors.grey.shade200;
      }
    }

    Color getBorderColor(int rank) {
      switch (rank) {
        case 1:
          return Colors.yellow[700]!.withAlpha(100);
        case 2:
          return Colors.grey[600]!.withAlpha(100);
        case 3:
          return Colors.amber[900]!.withAlpha(100);
        default:
          return Colors.grey.shade400;
      }
    }

    Widget podiumCard(int rank, Map<String, dynamic> user) {
      double size = rank == 1 ? 64 : 48;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getRankIcon(rank),
          const SizedBox(height: 4),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: getBgColor(rank),
              shape: BoxShape.circle,
              border: Border.all(color: getBorderColor(rank), width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              user['name'][0].toUpperCase(),
              style: TextStyle(
                fontSize: size / 2.5,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user['name'].split(' ')[0],
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            '${user['points']}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        podiumCard(2, leaderboardData[1]),
        podiumCard(1, leaderboardData[0]),
        podiumCard(3, leaderboardData[2]),
      ],
    );
  }
}
