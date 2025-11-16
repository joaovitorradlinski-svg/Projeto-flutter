import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/campanha.dart';
import '../models/personagem.dart';
import '../models/local.dart';

class FirebaseDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String currentUserId() => FirebaseAuth.instance.currentUser?.uid ?? '';

  Stream<List<Campanha>> getCampanhasPorUsuario(String userId) {
    return _db
        .collection('campanhas')
        .where('user_id', isEqualTo: userId)
        .orderBy('data_inicio', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => Campanha.fromMap(d.data(), d.id)).toList());
  }

  Future<void> addCampanha(Campanha c) async {
    final ref = await _db.collection('campanhas').add(c.toMap());
    await ref.update({'id': ref.id});
  }

  Future<void> updateCampanha(Campanha c) async {
    if (c.id == null || c.id!.isEmpty) return;
    await _db.collection('campanhas').doc(c.id).update(c.toMap());
  }

  Future<void> deleteCampanha(String id) async {
    if (id.isEmpty) return;

    final subPersonagens = await _db
        .collection('campanhas')
        .doc(id)
        .collection('personagens')
        .get();
    for (var d in subPersonagens.docs) {
      await d.reference.delete();
    }

    final subLocais =
        await _db.collection('campanhas').doc(id).collection('locais').get();
    for (var d in subLocais.docs) {
      await d.reference.delete();
    }

    await _db.collection('campanhas').doc(id).delete();
  }

  Stream<List<Personagem>> getPersonagensCampanha(String campanhaId) {
    return _db
        .collection('campanhas')
        .doc(campanhaId)
        .collection('personagens')
        .orderBy('nome')
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => Personagem.fromMap(d.data(), d.id)).toList());
  }

  Future<void> addPersonagem(Personagem p) async {
    final ref = await _db
        .collection('campanhas')
        .doc(p.campanhaId)
        .collection('personagens')
        .add(p.toMap());
    await ref.update({'id': ref.id});
  }

  Future<void> updatePersonagem(Personagem p) async {
    if (p.id == null || p.id!.isEmpty) return;
    await _db
        .collection('campanhas')
        .doc(p.campanhaId)
        .collection('personagens')
        .doc(p.id)
        .update(p.toMap());
  }

  Future<void> deletePersonagem(String campanhaId, String personagemId) async {
    if (personagemId.isEmpty) return;
    await _db
        .collection('campanhas')
        .doc(campanhaId)
        .collection('personagens')
        .doc(personagemId)
        .delete();
  }

  Stream<List<Local>> getLocaisCampanha(String campanhaId) {
    return _db
        .collection('campanhas')
        .doc(campanhaId)
        .collection('locais')
        .orderBy('nome')
        .snapshots()
        .map(
            (snap) => snap.docs.map((d) => Local.fromMap(d.data(), d.id)).toList());
  }

  Future<void> addLocal(Local l) async {
    final ref = await _db
        .collection('campanhas')
        .doc(l.campanhaId)
        .collection('locais')
        .add(l.toMap());
    await ref.update({'id': ref.id});
  }

  Future<void> updateLocal(Local l) async {
    if (l.id == null || l.id!.isEmpty) return;
    await _db
        .collection('campanhas')
        .doc(l.campanhaId)
        .collection('locais')
        .doc(l.id)
        .update(l.toMap());
  }

  Future<void> deleteLocal(String campanhaId, String localId) async {
    if (localId.isEmpty) return;
    await _db
        .collection('campanhas')
        .doc(campanhaId)
        .collection('locais')
        .doc(localId)
        .delete();
  }
}
