import 'package:flutter/material.dart';
import '../../models/personagem.dart';
import '../../services/firebase_db_service.dart';

class PersonagemFormScreen extends StatefulWidget {
  final String campanhaId;
  const PersonagemFormScreen({super.key, required this.campanhaId});

  @override
  State<PersonagemFormScreen> createState() => _PersonagemFormScreenState();
}

class _PersonagemFormScreenState extends State<PersonagemFormScreen> {
  final _nome = TextEditingController();
  final _classe = TextEditingController();
  final _raca = TextEditingController();
  final _descricao = TextEditingController();
  final _db = FirebaseDbService();
  bool _loading = false;

  Future<void> _save() async {
    setState(() => _loading = true);

    final p = Personagem(
      nome: _nome.text.trim(),
      classe: _classe.text.trim(),
      raca: _raca.text.trim(),
      descricao: _descricao.text.trim(),
      campanhaId: widget.campanhaId,
      userId: _db.currentUserId(),
    );

    await _db.addPersonagem(p);

    setState(() => _loading = false);

    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Personagem')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: [
          TextField(controller: _nome, decoration: const InputDecoration(labelText: 'Nome')),
          const SizedBox(height: 12),
          TextField(controller: _classe, decoration: const InputDecoration(labelText: 'Classe')),
          const SizedBox(height: 12),
          TextField(controller: _raca, decoration: const InputDecoration(labelText: 'Raça')),
          const SizedBox(height: 12),
          TextField(controller: _descricao, decoration: const InputDecoration(labelText: 'Descrição')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loading ? null : _save,
            child: _loading ? const CircularProgressIndicator() : const Text('Criar'),
          ),
        ]),
      ),
    );
  }
}
