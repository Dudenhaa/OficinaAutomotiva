class Pessoa {
  final int _id; // imutável
  String _nome;
  String _telefone;
  String _email;

  Pessoa({
    required int id,
    required String nome,
    required String telefone,
    required String email,
  })  : _id = id,
        _nome = nome,
        _telefone = telefone,
        _email = email {
    if (nome.trim().isEmpty) {
      throw ArgumentError('O nome não pode ser vazio.');
    }
  }

  int get id => _id;
  String get nome => _nome;
  String get telefone => _telefone;
  String get email => _email;

  set nome(String valor) {
    if (valor.trim().isEmpty) {
      throw ArgumentError('O nome não pode ser vazio.');
    }
    _nome = valor;
  }

  void atualizarContato(String telefone, String email) {
    _telefone = telefone;
    _email = email;
  }

  /// O id não é parâmetro: ele não pode ser alterado.
  Pessoa copyWith({String? nome, String? telefone, String? email}) {
    return Pessoa(
      id: _id,
      nome: nome ?? _nome,
      telefone: telefone ?? _telefone,
      email: email ?? _email,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'nome': _nome,
        'telefone': _telefone,
        'email': _email,
      };

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return Pessoa(
      id: map['id'] as int,
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
      email: map['email'] as String,
    );
  }

  @override
  String toString() =>
      'Pessoa(id: $_id, nome: $_nome, telefone: $_telefone, email: $_email)';
}