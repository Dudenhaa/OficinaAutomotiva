import 'pessoa.dart';

class Veiculo {
  final String _placa; // imutável
  String _modelo;
  String _marca;
  int _ano;
  Pessoa _responsavel;

  Veiculo({
    required String placa,
    required String modelo,
    required String marca,
    required int ano,
    required Pessoa responsavel,
  })  : _placa = placa.toUpperCase(),
        _modelo = modelo,
        _marca = marca,
        _ano = ano,
        _responsavel = responsavel {
    if (placa.trim().isEmpty) {
      throw ArgumentError('A placa não pode ser vazia.');
    }
    _validarAno(ano);
  }

  static void _validarAno(int ano) {
    if (ano < 1886 || ano > DateTime.now().year + 1) {
      throw ArgumentError('Ano inválido: $ano');
    }
  }

  String get placa => _placa;
  String get modelo => _modelo;
  String get marca => _marca;
  int get ano => _ano;
  Pessoa get responsavel => _responsavel;

  void atualizarDados(String modelo, String marca, int ano) {
    _validarAno(ano);
    _modelo = modelo;
    _marca = marca;
    _ano = ano;
  }

  void alterarResponsavel(Pessoa responsavel) {
    _responsavel = responsavel;
  }

  /// A placa não é parâmetro: ela não pode ser alterada.
  Veiculo copyWith({
    String? modelo,
    String? marca,
    int? ano,
    Pessoa? responsavel,
  }) {
    return Veiculo(
      placa: _placa,
      modelo: modelo ?? _modelo,
      marca: marca ?? _marca,
      ano: ano ?? _ano,
      responsavel: responsavel ?? _responsavel,
    );
  }

  Map<String, dynamic> toMap() => {
        'placa': _placa,
        'modelo': _modelo,
        'marca': _marca,
        'ano': _ano,
        'responsavel': _responsavel.toMap(),
      };

  factory Veiculo.fromMap(Map<String, dynamic> map) {
    return Veiculo(
      placa: map['placa'] as String,
      modelo: map['modelo'] as String,
      marca: map['marca'] as String,
      ano: map['ano'] as int,
      responsavel:
          Pessoa.fromMap(Map<String, dynamic>.from(map['responsavel'] as Map)),
    );
  }

  @override
  String toString() =>
      'Veiculo(placa: $_placa, $_marca $_modelo, ano: $_ano, responsavel: ${_responsavel.nome})';
}