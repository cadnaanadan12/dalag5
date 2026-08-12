import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  String _emailFromUsername(String username) => '$username@dalag.com';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final email = _emailFromUsername(username);
    final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final doc = await _db.collection('users').doc(cred.user!.uid).get();
    return doc.data() ?? {};
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String password,
    required String name,
    required String city,
  }) async {
    final email = _emailFromUsername(username);
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final profile = {
      'username': username,
      'email': email,
      'name': name,
      'city': city,
      'role': 'user',
    };
    await _db.collection('users').doc(cred.user!.uid).set(profile);
    return profile;
  }

  Future<void> logout() => _auth.signOut();
}
