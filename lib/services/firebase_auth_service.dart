import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  String currentUserId() => _auth.currentUser?.uid ?? '';

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<String> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'ok';
    } on FirebaseAuthException catch (e) {
      return _codeToMessage(e.code);
    }
  }

  Future<String> register({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return 'ok';
    } on FirebaseAuthException catch (e) {
      return _codeToMessage(e.code);
    }
  }

  Future<void> signOut() async => _auth.signOut();
  Future<void> logout() async => signOut();

  String _codeToMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Email inválido.';
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'email-already-in-use':
        return 'Email já cadastrado.';
      case 'weak-password':
        return 'Senha fraca.';
      default:
        return 'Erro: $code';
    }
  }
}
