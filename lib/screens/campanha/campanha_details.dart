// lib/screens/campanha/campanha_details.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/campanha.dart';
import '../../models/personagem.dart';
import '../../models/local.dart';
import '../../services/firebase_db_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/personagem_card.dart';
import '../../widgets/local_card.dart';

class CampanhaDetailsScreen extends StatefulWidget {
  final Campanha campanha;
  const CampanhaDetailsScreen({super.key, required this.campanha});

  @override
  State<CampanhaDetailsScreen> createState() => _CampanhaDetailsScreenState();
}

class _CampanhaDetailsScreenState extends State<CampanhaDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  final FirebaseDbService _db = FirebaseDbService();

  String cleanError(String err) {
    return err.replaceAll(RegExp(r'https?:\/\/[^\s]+'), '');
  }

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Future<void> _deleteCampanha() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir campanha'),
        content: const Text('Excluir campanha e tudo relacionado a ela?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
        ],
      ),
    );

    if (ok == true) {
      try {
        await _db.deleteCampanha(widget.campanha.id ?? '');
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(cleanError(e.toString()))),
          );
        }
      }
    }
  }

  Future<void> _confirmDeletePersonagem(Personagem p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir personagem'),
        content: Text('Excluir "${p.nome}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
        ],
      ),
    );

    if (ok == true) {
      try {
        await _db.deletePersonagem(widget.campanha.id!, p.id!);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(cleanError(e.toString()))),
          );
        }
      }
    }
  }

  Future<void> _confirmDeleteLocal(Local l) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir local'),
        content: Text('Excluir "${l.nome}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
        ],
      ),
    );

    if (ok == true) {
      try {
        await _db.deleteLocal(widget.campanha.id!, l.id!);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(cleanError(e.toString()))),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.campanha;

    return Scaffold(
      appBar: AppBar(
        title: Text(c.titulo, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.pushNamed(context, '/campanha/edit', arguments: c),
          ),
          IconButton(icon: const Icon(Icons.delete), onPressed: _deleteCampanha),
        ],
        bottom: TabBar(
          controller: _tab,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(icon: Icon(Icons.info_outline), text: 'Info'),
            Tab(icon: Icon(Icons.people), text: 'Personagens'),
            Tab(icon: Icon(Icons.place), text: 'Locais'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _infoTab(c),
          _personagensTab(c.id!),
          _locaisTab(c.id!),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _tab,
        builder: (_, __) {
          if (_tab.index == 1) {
            return FloatingActionButton.extended(
              onPressed: () =>
                  Navigator.pushNamed(context, '/personagem/new', arguments: c.id),
              icon: const Icon(Icons.person_add),
              label: const Text('Novo personagem'),
            );
          }

          if (_tab.index == 2) {
            return FloatingActionButton.extended(
              onPressed: () =>
                  Navigator.pushNamed(context, '/local/new', arguments: c.id),
              icon: const Icon(Icons.add_location),
              label: const Text('Novo local'),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _infoTab(Campanha c) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('Descrição', style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(c.descricao.isEmpty ? '— Sem descrição —' : c.descricao),
          const SizedBox(height: 16),
          Row(children: [const Icon(Icons.calendar_today), const SizedBox(width: 8), Text('Início: ${c.dataInicio}')]),
          const SizedBox(height: 8),
          Row(children: [const Icon(Icons.flag), const SizedBox(width: 8), Text('Status: ${c.status}')]),
        ],
      ),
    );
  }

  Widget _personagensTab(String campanhaId) {
    return StreamBuilder<List<Personagem>>(
      stream: _db.getPersonagensCampanha(campanhaId),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snap.hasError) {
          return Center(child: Text(cleanError(snap.error.toString())));
        }

        final list = snap.data ?? [];
        if (list.isEmpty) return const Center(child: Text('Nenhum personagem'));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (_, i) {
            final p = list[i];
            return PersonagemCard(
              personagem: p,
              onEdit: () => Navigator.pushNamed(context, '/personagem/edit',
                  arguments: {'campanhaId': campanhaId, 'personagem': p}),
              onDelete: () => _confirmDeletePersonagem(p),
            );
          },
        );
      },
    );
  }

  Widget _locaisTab(String campanhaId) {
    return StreamBuilder<List<Local>>(
      stream: _db.getLocaisCampanha(campanhaId),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snap.hasError) {
          return Center(child: Text(cleanError(snap.error.toString())));
        }

        final list = snap.data ?? [];
        if (list.isEmpty) return const Center(child: Text('Nenhum local'));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (_, i) {
            final l = list[i];
            return LocalCard(
              local: l,
              onEdit: () => Navigator.pushNamed(context, '/local/edit',
                  arguments: {'campanhaId': campanhaId, 'local': l}),
              onDelete: () => _confirmDeleteLocal(l),
            );
          },
        );
      },
    );
  }
}
