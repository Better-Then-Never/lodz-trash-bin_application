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

  Future<void> logout() async {
    await _auth.signOut();
    _currentUserData = null;
    notifyListeners();
  }
}
