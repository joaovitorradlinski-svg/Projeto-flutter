import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_auth_service.dart';
import '../theme/app_theme.dart';
import '../models/campanha.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuthService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      drawer: _buildDrawer(context),

      body: user == null
          ? const Center(child: Text("Erro: usuário não autenticado"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("campanhas")
                  .where("user_id", isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro Firestore: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhuma campanha cadastrada",
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  );
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    data["id"] = doc.id;

                    return _buildCampanhaCard(context, data);
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/campanha/new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppTheme.surface,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppTheme.primaryColor),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  FirebaseAuthService().currentUser?.email ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.white),
              title: const Text("Dashboard", style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),

            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Sair", style: TextStyle(color: Colors.redAccent)),
              onTap: () async {
                await FirebaseAuthService().signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampanhaCard(BuildContext context, Map<String, dynamic> c) {
    return Card(
      color: AppTheme.surface,
      child: ListTile(
        title: Text(c["titulo"], style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          c["descricao"] ?? "",
          style: const TextStyle(color: AppTheme.textSecondary),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/campanha/details',
            arguments: Campanha(
              id: c["id"],
              titulo: c["titulo"],
              descricao: c["descricao"] ?? "",
              dataInicio: c["data_inicio"] ?? "",
              dataFim: c["data_fim"] ?? "",
              status: c["status"] ?? "",
              userId: c["user_id"],
            ),
          );
        },
      ),
    );
  }
}
