class Campanha {
  final String? id;
  final String titulo;
  final String descricao;
  final String dataInicio;
  final String dataFim;
  final String status;
  final String userId;

  Campanha({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataInicio,
    required this.dataFim,
    required this.status,
    required this.userId,
  });

  factory Campanha.fromMap(Map<String, dynamic> map, String docId) {
    return Campanha(
      id: docId,
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      dataInicio: map['data_inicio'] ?? '',
      dataFim: map['data_fim'] ?? '',
      status: map['status'] ?? 'ativa',
      userId: map['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'titulo': titulo,
        'descricao': descricao,
        'data_inicio': dataInicio,
        'data_fim': dataFim,
        'status': status,
        'user_id': userId,
      };
}
