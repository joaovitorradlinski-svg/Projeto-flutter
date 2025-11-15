import 'package:flutter/material.dart';
import '../models/personagem.dart';

class PersonagemCard extends StatelessWidget {
  final Personagem personagem;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PersonagemCard({super.key, required this.personagem, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(personagem.nome),
        subtitle: Text('${personagem.classe} • ${personagem.raca}'),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
        ]),
      ),
    );
  }
}
