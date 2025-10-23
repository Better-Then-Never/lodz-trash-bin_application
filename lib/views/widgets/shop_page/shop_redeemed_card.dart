import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/pages/show_reward_page.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';

class ShopRedeemedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String discountLabel;
  final String categoryLabel;

  const ShopRedeemedCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.discountLabel,
    required this.categoryLabel,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return CustomCard(
      outerPadding: EdgeInsetsGeometry.zero,
      withBorder: true,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              const Icon(LucideIcons.tag, size: 22),
              SizedBox(width: screenWidth * 0.03),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  discountLabel,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              CustomCard(
                outerPadding: EdgeInsets.only(left: screenWidth * 0.02),
                padding: EdgeInsetsGeometry.zero,
                width: screenWidth * 0.25,
                height: screenHeight * 0.03,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      categoryLabel,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(color: const Color.fromARGB(255, 196, 196, 196)),
          Row(
            children: [
              const Text(
                'Ważny do: 12-10-2026',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowRewardPage(
                        discountLabel: discountLabel,
                        title: title,
                        subtitle: subtitle,
                      ),
                    ),
                  );
                },
                child: CustomCard(
                  withBorder: false,
                  padding: EdgeInsetsGeometry.zero,
                  color: const Color.fromARGB(255, 114, 228, 69),
                  height: screenHeight * 0.04,
                  width: screenWidth * 0.3,
                  borderRadius: 8,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: const Text(
                        'Pokaż',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
