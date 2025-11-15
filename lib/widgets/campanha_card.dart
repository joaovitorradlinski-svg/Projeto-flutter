import 'package:flutter/material.dart';
import '../models/campanha.dart';
import 'package:google_fonts/google_fonts.dart';

class CampanhaCard extends StatelessWidget {
  final Campanha campanha;
  final VoidCallback? onTap;

  const CampanhaCard({super.key, required this.campanha, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(campanha.titulo, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
        subtitle: Text(campanha.descricao),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
