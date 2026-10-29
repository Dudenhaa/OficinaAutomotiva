enum Situacao {
  emAndamento,
  concluido,
  cancelado;

  /// Reconstrói a situação a partir do nome salvo no Map.
  factory Situacao.fromName(String nome) {
    return Situacao.values.firstWhere(
      (s) => s.name == nome,
      orElse: () => throw ArgumentError('Situação inválida: $nome'),
    );
  }
}