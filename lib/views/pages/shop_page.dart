import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/widgets/shop_page/shop_my_points_count.dart';
import 'package:lodz_trash_bin/views/widgets/shop_page/shop_rewards_list.dart';
import 'package:lodz_trash_bin/views/widgets/shop_page/shop_redeemed_list.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool showRewards = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final userService = Provider.of<UserService>(context);

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
                  points: userService.pointsBalance,
                ),
              ],
            ),

            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ToggleButton(
                    label: "Odbierz",
                    selected: showRewards,
                    onTap: () => setState(() => showRewards = true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ToggleButton(
                    label: "Moje",
                    selected: !showRewards,
                    onTap: () => setState(() => showRewards = false),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: showRewards
                    ? ShopRewardsList(key: ValueKey(userService.rewards.length))
                    : ShopRedeemedList(
                        key: ValueKey(userService.rewards.length),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ToggleButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? const Color.fromARGB(255, 76, 218, 83)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
