import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';

class SessionsInTotal extends StatelessWidget {
  const SessionsInTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(LucideIcons.chart_column_big),
              SizedBox(height: 3),
              Text(
                'Łączna liczba sesji',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const Row(
            children: [
              Text('42', style: TextStyle(fontSize: 30, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
