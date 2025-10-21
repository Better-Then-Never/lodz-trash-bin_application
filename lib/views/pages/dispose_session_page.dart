import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/services/user_service.dart';

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
                backgroundColor: Colors.black,
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.25),
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Wrzuć śmieci do kosza',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Za to dostaniesz punkty',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '+$pointsToAdd',
                    style: TextStyle(
                      fontSize: screenHeight * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
