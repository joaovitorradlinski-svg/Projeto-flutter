class Local {
  final String? id;
  final String nome;
  final String descricao;
  final String campanhaId;
  final String userId;

  Local({
    this.id,
    required this.nome,
    required this.descricao,
    required this.campanhaId,
    required this.userId,
  });

  factory Local.fromMap(Map<String, dynamic> map, String docId) {
    return Local(
      id: docId,
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      campanhaId: map['campanha_id'] ?? '',
      userId: map['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'nome': nome,
        'descricao': descricao,
        'campanha_id': campanhaId,
        'user_id': userId,
      };
}
