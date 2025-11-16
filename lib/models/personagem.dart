class Personagem {
  final String? id;
  final String nome;
  final String classe;
  final String raca;
  final String descricao;
  final String campanhaId;
  final String userId;

  Personagem({
    this.id,
    required this.nome,
    required this.classe,
    required this.raca,
    required this.descricao,
    required this.campanhaId,
    required this.userId,
  });

  factory Personagem.fromMap(Map<String, dynamic> map, String docId) {
    return Personagem(
      id: docId,
      nome: map['nome'] ?? '',
      classe: map['classe'] ?? '',
      raca: map['raca'] ?? '',
      descricao: map['descricao'] ?? '',
      campanhaId: map['campanha_id'] ?? '',
      userId: map['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'nome': nome,
        'classe': classe,
        'raca': raca,
        'descricao': descricao,
        'campanha_id': campanhaId,
        'user_id': userId,
      };
}
