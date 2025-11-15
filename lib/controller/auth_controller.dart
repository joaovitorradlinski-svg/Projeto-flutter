import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 
  User? get usuario => _auth.currentUser;
  User? get user => _auth.currentUser;

  Stream<User?> get usuarioStream => _auth.authStateChanges();

 
  Future<String?> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  
  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  
  Future<void> signOut() async {
    await logout();
  }
}
