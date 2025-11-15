import 'package:flutter/material.dart';
import '../../models/campanha.dart';
import '../../services/firebase_db_service.dart';

class CampanhaFormScreen extends StatefulWidget {
  final Campanha? campanha;
  const CampanhaFormScreen({super.key, this.campanha});

  @override
  State<CampanhaFormScreen> createState() => _CampanhaFormScreenState();
}

class _CampanhaFormScreenState extends State<CampanhaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titulo = TextEditingController();
  final _descricao = TextEditingController();
  String status = 'ativa';
  final _db = FirebaseDbService();
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    if (widget.campanha != null) {
      _titulo.text = widget.campanha!.titulo;
      _descricao.text = widget.campanha!.descricao;
      status = widget.campanha!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final edit = widget.campanha != null;

    return Scaffold(
      appBar: AppBar(title: Text(edit ? 'Editar Campanha' : 'Nova Campanha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titulo,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descricao,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField(
                value: status,
                items: const [
                  DropdownMenuItem(value: 'ativa', child: Text('Ativa')),
                  DropdownMenuItem(value: 'pausada', child: Text('Pausada')),
                  DropdownMenuItem(value: 'finalizada', child: Text('Finalizada')),
                ],
                onChanged: (v) => setState(() => status = v ?? 'ativa'),
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loading ? null : _save,
                child: _loading
                    ? const CircularProgressIndicator()
                    : Text(edit ? 'Salvar' : 'Criar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final edit = widget.campanha != null;

    final camp = Campanha(
      id: widget.campanha?.id,
      titulo: _titulo.text.trim(),
      descricao: _descricao.text.trim(),
      dataInicio: edit
          ? widget.campanha!.dataInicio
          : DateTime.now().toIso8601String().split('T').first,
      dataFim: edit ? widget.campanha!.dataFim : "",
      status: status,
      userId: edit ? widget.campanha!.userId : _db.currentUserId(),
    );

    try {
      if (!edit) {
        await _db.addCampanha(camp);
      } else {
        await _db.updateCampanha(camp);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
      }
    }

    setState(() => _loading = false);

    if (mounted) Navigator.pop(context, true);
  }
}
