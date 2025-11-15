import 'package:flutter/material.dart';
import '../../models/personagem.dart';
import '../../services/firebase_db_service.dart';

class PersonagemEditScreen extends StatefulWidget {
  final String campanhaId;
  final Personagem personagem;

  const PersonagemEditScreen({
    super.key,
    required this.campanhaId,
    required this.personagem,
  });

  @override
  State<PersonagemEditScreen> createState() => _PersonagemEditScreenState();
}

class _PersonagemEditScreenState extends State<PersonagemEditScreen> {
  final _nome = TextEditingController();
  final _classe = TextEditingController();
  final _raca = TextEditingController();
  final _descricao = TextEditingController();
  final _db = FirebaseDbService();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nome.text = widget.personagem.nome;
    _classe.text = widget.personagem.classe;
    _raca.text = widget.personagem.raca;
    _descricao.text = widget.personagem.descricao;
  }

  Future<void> _save() async {
    setState(() => _loading = true);

    final p = Personagem(
      id: widget.personagem.id,
      nome: _nome.text.trim(),
      classe: _classe.text.trim(),
      raca: _raca.text.trim(),
      descricao: _descricao.text.trim(),
      campanhaId: widget.campanhaId,
      userId: _db.currentUserId(),
    );

    await _db.updatePersonagem(p);

    setState(() => _loading = false);

    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Personagem')),
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
            child: _loading ? const CircularProgressIndicator() : const Text('Salvar'),
          ),
        ]),
      ),
    );
  }
}
