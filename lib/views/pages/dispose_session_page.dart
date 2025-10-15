import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DisposeSessionPage extends StatefulWidget {
  final String binId;

  const DisposeSessionPage({super.key, required this.binId});

  @override
  State<DisposeSessionPage> createState() => _DisposeSessionPageState();
}

class _DisposeSessionPageState extends State<DisposeSessionPage> {
  final String databaseUrl = dotenv.env['FIREBASE_DB_URL'] ?? '';

  @override
  void initState() {
    super.initState();
    _updateLedStatus(true);
  }

  Future<void> _updateLedStatus(bool status) async {
    final url = Uri.parse(
      '$databaseUrl/BinsData/${widget.binId}/led_status.json',
    );

    try {
      final response = await http.put(url, body: jsonEncode(status));

      if (response.statusCode == 200) {
        print('LED status updated successfully: $status');
      } else {
        print('Failed to update LED status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating LED status: $e');
    }
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
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Wrzuć śmieci do kosza',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                FittedBox(
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
                    '+0',
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
