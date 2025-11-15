import 'package:flutter/material.dart';
import '../models/campanha.dart';
import '../services/firebase_auth_service.dart';
import '../services/firebase_db_service.dart';

class CampanhaController extends ChangeNotifier {
  final FirebaseDbService _db = FirebaseDbService();
  final FirebaseAuthService _auth = FirebaseAuthService();

  bool loading = false;
  String? errorMessage;

  Stream<List<Campanha>> listarCampanhasDoUsuario() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }
    return _db.getCampanhasPorUsuario(user.uid);
  }

  Future<bool> criarCampanha(Campanha campanha) async {
    try {
      loading = true;
      notifyListeners();

      await _db.addCampanha(campanha);

      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> editarCampanha(Campanha campanha) async {
    try {
      loading = true;
      notifyListeners();

      await _db.updateCampanha(campanha);

      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      loading = false;
      notifyListeners();
      return false;
    }
  }


  Future<bool> deletarCampanha(String id) async {
    try {
      loading = true;
      notifyListeners();

      await _db.deleteCampanha(id);

      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
