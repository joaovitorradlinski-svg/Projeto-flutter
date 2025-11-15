import 'package:flutter/material.dart';
import '../../models/local.dart';
import '../../services/firebase_db_service.dart';

class LocalEditScreen extends StatefulWidget {
  final String campanhaId;
  final Local local;
  const LocalEditScreen({super.key, required this.campanhaId, required this.local});

  @override
  State<LocalEditScreen> createState() => _LocalEditScreenState();
}

class _LocalEditScreenState extends State<LocalEditScreen> {
  final _nome = TextEditingController();
  final _descricao = TextEditingController();
  final _db = FirebaseDbService();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nome.text = widget.local.nome;
    _descricao.text = widget.local.descricao;
  }

  Future<void> _save() async {
    setState(() => _loading = true);

    final l = Local(
      id: widget.local.id,
      nome: _nome.text.trim(),
      descricao: _descricao.text.trim(),
      campanhaId: widget.campanhaId,
      userId: _db.currentUserId(),
    );

    await _db.updateLocal(l);

    setState(() => _loading = false);

    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Local')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: [
          TextField(controller: _nome, decoration: const InputDecoration(labelText: 'Nome')),
          const SizedBox(height: 12),
          TextField(controller: _descricao, decoration: const InputDecoration(labelText: 'Descrição')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loading ? null : _save,
            child: _loading ? const CircularProgressIndicator() : const Text('Salvar'),
          ),
        ]),
      ),
    );
  }
}
