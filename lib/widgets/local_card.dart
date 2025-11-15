import 'package:flutter/material.dart';
import '../models/local.dart';

class LocalCard extends StatelessWidget {
  final Local local;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const LocalCard({super.key, required this.local, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(local.nome),
        subtitle: Text(local.descricao),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
        ]),
      ),
    );
  }
}
