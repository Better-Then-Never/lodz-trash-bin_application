import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? _currentUserData;

  Map<String, dynamic>? get currentUserData => _currentUserData;

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
    notifyListeners();

    _firestore.collection('users').doc(user.uid).snapshots().listen((doc) {
      _currentUserData = doc.data();
      notifyListeners();
    });
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
    notifyListeners();
  }
}
