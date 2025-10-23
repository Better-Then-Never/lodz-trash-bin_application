import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? _currentUserData;
  List<Map<String, dynamic>> _rewards = [];

  Map<String, dynamic>? get currentUserData => _currentUserData;
  List<Map<String, dynamic>> get rewards => _rewards;
  List<String> get redeemedOfferIds {
    return _rewards
        .map((reward) => (reward['id'] as String?) ?? '')
        .where((id) => id.isNotEmpty)
        .toList();
  }

  User? get currentUser => _auth.currentUser;

  String? get name => _currentUserData?['name'];
  String? get username => _currentUserData?['username'];
  String? get email => _currentUserData?['email'];
  int get pointsBalance => _currentUserData?['pointsBalance'] ?? 0;
  int get totalSessions => _currentUserData?['totalSessions'] ?? 0;
  int get currentMonthSessions =>
      _currentUserData?['currentMonthSessions'] ?? 0;

  Future<void> init() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    _currentUserData = doc.data();

    await _fetchRewards();
    notifyListeners();

    _firestore.collection('users').doc(user.uid).snapshots().listen((
      doc,
    ) async {
      _currentUserData = doc.data();
      await _fetchRewards();
      notifyListeners();
    });
  }

  bool _isFetchingRewards = false;

  Future<void> _fetchRewards() async {
    if (_isFetchingRewards) return;
    _isFetchingRewards = true;

    final rewardsRefs = _currentUserData?['rewards'];
    final List<Map<String, dynamic>> fetched = [];

    if (rewardsRefs is List) {
      for (final ref in rewardsRefs) {
        if (ref is DocumentReference) {
          final offerDoc = await ref.get();
          if (offerDoc.exists) {
            final data = offerDoc.data() as Map<String, dynamic>;
            data['id'] = offerDoc.id;
            fetched.add(data);
          }
        }
      }
    }

    _rewards = fetched;
    _isFetchingRewards = false;
    notifyListeners();
  }

  Future<void> addRewardReference(String offerId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final DocumentReference offerRef = _firestore
        .collection('offers')
        .doc(offerId);

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'rewards': FieldValue.arrayUnion([offerRef]),
      });

      final offerDoc = await offerRef.get();
      if (offerDoc.exists) {
        final data = offerDoc.data() as Map<String, dynamic>;
        data['id'] = offerDoc.id;

        if (!_rewards.any((r) => r['id'] == offerDoc.id)) {
          _rewards.add(data);
          notifyListeners();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding reward reference for offer $offerId: $e');
      }
    }
  }

  Future<void> updatePoints(int newBalance) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).update({
      'pointsBalance': newBalance,
    });

    _currentUserData?['pointsBalance'] = newBalance;
    notifyListeners();
  }

  Future<void> changePoints(int amount) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final current = _currentUserData?['pointsBalance'] ?? 0;
    final updated = current + amount;

    await updatePoints(updated);
  }

  Future<void> incrementSessions() async {
    final user = _auth.currentUser;
    if (user == null) return;
    final currentTotal = _currentUserData?['totalSessions'] ?? 0;
    final currentMonth = _currentUserData?['currentMonthSessions'] ?? 0;
    final updatedTotal = currentTotal + 1;
    final updatedMonth = currentMonth + 1;
    await _firestore.collection('users').doc(user.uid).update({
      'totalSessions': updatedTotal,
      'currentMonthSessions': updatedMonth,
    });

    _currentUserData?['totalSessions'] = updatedTotal;
    _currentUserData?['currentMonthSessions'] = updatedMonth;
    notifyListeners();
  }

  Future<void> logout() async {
    await _auth.signOut();
    _currentUserData = null;
    _rewards = [];
    notifyListeners();
  }
}
