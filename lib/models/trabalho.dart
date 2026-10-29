class Trabalho {
  final int _id; // imutável
  String _descricao;
  double _valorPadrao;

  Trabalho({
    required int id,
    required String descricao,
    required double valorPadrao,
  })  : _id = id,
        _descricao = descricao,
        _valorPadrao = valorPadrao {
    if (descricao.trim().isEmpty) {
      throw ArgumentError('A descrição não pode ser vazia.');
    }
    if (valorPadrao < 0) {
      throw ArgumentError('O valor não pode ser negativo.');
    }
  }

  int get id => _id;
  String get descricao => _descricao;
  double get valorPadrao => _valorPadrao;

  set descricao(String valor) {
    if (valor.trim().isEmpty) {
      throw ArgumentError('A descrição não pode ser vazia.');
    }
    _descricao = valor;
  }

  /// Reajusta o valor do tipo de trabalho.
  void alterarValor(double novoValor) {
    if (novoValor < 0) {
      throw ArgumentError('O valor não pode ser negativo.');
    }
    _valorPadrao = novoValor;
  }

  Trabalho copyWith({String? descricao, double? valorPadrao}) {
    return Trabalho(
      id: _id,
      descricao: descricao ?? _descricao,
      valorPadrao: valorPadrao ?? _valorPadrao,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'descricao': _descricao,
        'valorPadrao': _valorPadrao,
      };

  factory Trabalho.fromMap(Map<String, dynamic> map) {
    return Trabalho(
      id: map['id'] as int,
      descricao: map['descricao'] as String,
      valorPadrao: (map['valorPadrao'] as num).toDouble(),
    );
  }

  @override
  String toString() =>
      'Trabalho(id: $_id, descricao: $_descricao, valorPadrao: R\$ ${_valorPadrao.toStringAsFixed(2)})';
}