import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';
import 'package:barcode_widget/barcode_widget.dart';

class SuccessfullPurchasePage extends StatefulWidget {
  const SuccessfullPurchasePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.discountLabel,
  });

  final String title;
  final String subtitle;
  final String discountLabel;

  @override
  State<SuccessfullPurchasePage> createState() =>
      _SuccessfullPurchasePageState();
}

class _SuccessfullPurchasePageState extends State<SuccessfullPurchasePage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sukces!'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        toolbarHeight: screenHeight * 0.05,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: screenWidth * 0.3,
                color: Color.fromARGB(255, 129, 239, 85),
              ),
              const Text(
                'Rabat odebrany!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                'Pokaż ten kod w sklepie',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomCard(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.subtitle,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        CustomCard(
                          withBorder: false,
                          padding: EdgeInsetsGeometry.zero,
                          color: Colors.black,
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          borderRadius: 8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: screenWidth * 0.01),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      widget.discountLabel,
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
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Kod rabatowy',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    CustomCard(
                      color: const Color.fromARGB(255, 227, 227, 227),
                      width: double.infinity,
                      height: screenHeight * 0.08,
                      child: Center(
                        child: Text(
                          '6P9Q-9XLM-FMCS',
                          style: TextStyle(fontSize: screenWidth * 0.05),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Zeksanuj w sklepie',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: '6P9Q-9XLM-FMCS',
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.1,
                    ),
                    Divider(color: const Color.fromARGB(255, 225, 225, 225)),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.tag,
                          size: screenWidth * 0.05,
                          color: Colors.grey,
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Kategoria: Transport',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Ważny do: 12-10-2026',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Wróć do sklepu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
