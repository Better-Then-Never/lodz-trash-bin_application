import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';

class DisposeSessionPage extends StatefulWidget {
  final String binId;

  const DisposeSessionPage({
    super.key,
    required this.binId,
    required this.userService,
  });

  final UserService userService;

  @override
  State<DisposeSessionPage> createState() => _DisposeSessionPageState();
}

class _DisposeSessionPageState extends State<DisposeSessionPage> {
  late DatabaseReference binRef;
  int startingTimesDisposed = 0;
  int pointsToAdd = 0;

  StreamSubscription<DatabaseEvent>? _timesDisposedSubscription;

  @override
  void initState() {
    super.initState();

    binRef = FirebaseDatabase.instance
        .ref()
        .child('BinsData')
        .child(widget.binId);

    _updateLedStatus(true);

    binRef.child('times_disposed').get().then((snapshot) {
      final value = snapshot.value;
      if (value is int) {
        startingTimesDisposed = value;
      }

      _timesDisposedSubscription = binRef
          .child('times_disposed')
          .onValue
          .listen((event) {
            final currentValue = event.snapshot.value;
            if (currentValue is int) {
              final added = currentValue - startingTimesDisposed;
              if (added > pointsToAdd) {
                setState(() {
                  pointsToAdd = added;
                });
              }
            }
          });
    });
  }

  Future<void> _updateLedStatus(bool status) async {
    try {
      await binRef.child('led_status').set(status);
      print('LED status updated: $status');
    } catch (e) {
      print('Error updating LED status: $e');
    }
  }

  @override
  void dispose() {
    _timesDisposedSubscription?.cancel();
    _updateLedStatus(false);
    final userService = widget.userService;
    if (pointsToAdd > 0) {
      userService.changePoints(pointsToAdd);
      userService.incrementSessions();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: screenHeight * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                _updateLedStatus(false);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Już wszystko :)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: screenHeight * 0.2),
            CustomCard(
              width: double.infinity,
              outerPadding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Wrzuć śmieci do kosza',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Za to dostaniesz punkty',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '+$pointsToAdd',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomCard(
              width: double.infinity,
              outerPadding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📱 Bin ID: #BTN-1411-UL',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '📍 Biblioteka Uniwersytetu Łódzkiego',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/ecopoint-logo.png',
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
