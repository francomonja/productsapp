import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../app.locator.dart';
import '../constants/storage_keys.dart';

class AuthService {
  final FlutterSecureStorage _secureStorage = locator<FlutterSecureStorage>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<bool> isAuthenticated() async {
    return await _secureStorage.read(key: userToken) != null;
  }

  Future<void> onLogIn(email, password) async {
    try {
      final AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      UserCredential? userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      String? deviceToken = await userCredential.user!.getIdToken(true);
      _secureStorage.write(key: userToken, value: deviceToken);
      print('is logged');
    } catch (e) {
      rethrow;
    }
  }
}
