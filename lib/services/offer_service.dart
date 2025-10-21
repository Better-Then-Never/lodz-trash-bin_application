import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class OfferService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _offers = [];

  List<Map<String, dynamic>> get offers => _offers;

  Future<void> init() async {
    _firestore.collection('offers').snapshots().listen((snapshot) {
      _offers = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'brand': data['brand'] ?? '',
          'category': data['category'] ?? '',
          'expires': data['expires'],
          'pricePoints': data['pricePoints'] ?? 0,
          'discountInPercents':
              data['discountInPercents'] ?? data['discount_in_percents'] ?? 0,
          'subtitle': data['subtitle'] ?? '',
          'title': data['title'] ?? '',
        };
      }).toList();

      notifyListeners();
    });
  }

  Future<void> fetchOnce() async {
    final snapshot = await _firestore.collection('offers').get();
    _offers = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'brand': data['brand'] ?? '',
        'category': data['category'] ?? '',
        'expires': data['expires'],
        'pricePoints': data['pricePoints'] ?? 0,
        'discountInPercents':
            data['discountInPercents'] ?? data['discount_in_percents'] ?? 0,
        'subtitle': data['subtitle'] ?? '',
        'title': data['title'] ?? '',
      };
    }).toList();
    notifyListeners();
  }
}
