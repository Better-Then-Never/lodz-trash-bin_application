import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';

class ShopMyPointsCount extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final int points;

  const ShopMyPointsCount({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      withBorder: false,
      padding: EdgeInsetsGeometry.zero,
      color: Colors.black,
      height: screenHeight * 0.05,
      width: screenWidth * 0.3,
      borderRadius: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(LucideIcons.coins, color: Colors.white, size: 22),
            SizedBox(width: screenWidth * 0.01),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$points',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
