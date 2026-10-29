import 'situacao.dart';
import 'trabalho.dart';

class Atendimento {
  final int _id; // imutável
  final DateTime _dataEntrada; // imutável
  DateTime? _dataSaida; // preenchida ao concluir/cancelar
  String _problema;
  Situacao _situacao;
  final List<Trabalho> _trabalhos;

  Atendimento({
    required int id,
    DateTime? dataEntrada,
    DateTime? dataSaida,
    required String problema,
    Situacao situacao = Situacao.emAndamento,
    List<Trabalho> trabalhos = const [],
  })  : _id = id,
        _dataEntrada = dataEntrada ?? DateTime.now(),
        _dataSaida = dataSaida,
        _problema = problema,
        _situacao = situacao,
        _trabalhos = List<Trabalho>.of(trabalhos) {
    if (problema.trim().isEmpty) {
      throw ArgumentError('O problema não pode ser vazio.');
    }
    if (situacao == Situacao.concluido && _trabalhos.isEmpty) {
      throw StateError(
          'Um atendimento não pode ser concluído sem ao menos um trabalho.');
    }
  }

  int get id => _id;
  DateTime get dataEntrada => _dataEntrada;
  DateTime? get dataSaida => _dataSaida;
  String get problema => _problema;
  Situacao get situacao => _situacao;

  /// Lista somente leitura: alterações passam por adicionar/removerTrabalho.
  List<Trabalho> get trabalhos => List.unmodifiable(_trabalhos);

  set problema(String valor) {
    if (valor.trim().isEmpty) {
      throw ArgumentError('O problema não pode ser vazio.');
    }
    _problema = valor;
  }

  void _exigirEmAndamento() {
    if (_situacao != Situacao.emAndamento) {
      throw StateError(
          'Operação permitida apenas para atendimentos em andamento.');
    }
  }

  void adicionarTrabalho(Trabalho trabalho) {
    _exigirEmAndamento();
    _trabalhos.add(trabalho);
  }

  void removerTrabalho(Trabalho trabalho) {
    _exigirEmAndamento();
    _trabalhos.removeWhere((t) => t.id == trabalho.id);
  }

  double calcularTotal() {
    return _trabalhos.fold(0.0, (soma, t) => soma + t.valorPadrao);
  }

  void concluir() {
    _exigirEmAndamento();
    if (_trabalhos.isEmpty) {
      throw StateError(
          'Um atendimento não pode ser concluído sem ao menos um trabalho.');
    }
    _situacao = Situacao.concluido;
    _dataSaida = DateTime.now();
  }

  void cancelar() {
    _exigirEmAndamento();
    _situacao = Situacao.cancelado;
    _dataSaida = DateTime.now();
  }

  /// id e dataEntrada não são parâmetros: não podem ser alterados.
  /// Se o novo estado violar uma regra (ex.: concluído sem trabalhos),
  /// o construtor lança erro.
  Atendimento copyWith({
    DateTime? dataSaida,
    String? problema,
    Situacao? situacao,
    List<Trabalho>? trabalhos,
  }) {
    return Atendimento(
      id: _id,
      dataEntrada: _dataEntrada,
      dataSaida: dataSaida ?? _dataSaida,
      problema: problema ?? _problema,
      situacao: situacao ?? _situacao,
      trabalhos: trabalhos ?? _trabalhos,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'dataEntrada': _dataEntrada.toIso8601String(),
        'dataSaida': _dataSaida?.toIso8601String(),
        'problema': _problema,
        'situacao': _situacao.name,
        'trabalhos': _trabalhos.map((t) => t.toMap()).toList(),
      };

  factory Atendimento.fromMap(Map<String, dynamic> map) {
    final trabalhosMap = (map['trabalhos'] as List?) ?? [];
    final dataSaida = map['dataSaida'] as String?;
    return Atendimento(
      id: map['id'] as int,
      dataEntrada: DateTime.parse(map['dataEntrada'] as String),
      dataSaida: dataSaida == null ? null : DateTime.parse(dataSaida),
      problema: map['problema'] as String,
      situacao: Situacao.fromName(map['situacao'] as String),
      trabalhos: trabalhosMap
          .map((t) => Trabalho.fromMap(Map<String, dynamic>.from(t as Map)))
          .toList(),
    );
  }

  @override
  String toString() =>
      'Atendimento(id: $_id, entrada: $_dataEntrada, saida: $_dataSaida, '
      'problema: $_problema, situacao: ${_situacao.name}, '
      'trabalhos: ${_trabalhos.length}, total: R\$ ${calcularTotal().toStringAsFixed(2)})';
}