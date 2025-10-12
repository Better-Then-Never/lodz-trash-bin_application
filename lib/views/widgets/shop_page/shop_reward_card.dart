import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/views/pages/successfull_purchase.page.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';

class ShopRewardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String discountLabel;
  final String categoryLabel;
  final int points;

  const ShopRewardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.discountLabel,
    required this.categoryLabel,
    required this.points,
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
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              const Icon(LucideIcons.coins, color: Colors.grey, size: 22),
              SizedBox(width: screenWidth * 0.03),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$points punktów',
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      actionsPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      title: const Text(
                        'Potwierdzenie',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        'Czy na pewno chcesz odebrać $title za $points punktów?',
                        style: const TextStyle(fontSize: 16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Nie'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SuccessfullPurchasePage(
                                  discountLabel: discountLabel,
                                  title: title,
                                  subtitle: subtitle,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color.fromARGB(
                                  255,
                                  114,
                                  228,
                                  69,
                                ),
                                duration: Duration(seconds: 2),
                                content: Text('Nagroda odebrana!'),
                              ),
                            );
                          },
                          child: const Text('Odbierz'),
                        ),
                      ],
                    ),
                  );
                },
                child: CustomCard(
                  withBorder: false,
                  padding: EdgeInsetsGeometry.zero,
                  color: const Color.fromARGB(255, 114, 228, 69),
                  height: screenHeight * 0.04,
                  width: screenWidth * 0.2,
                  borderRadius: 8,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: const Text(
                        'Odbierz',
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
