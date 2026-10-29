import 'package:oficina_automotiva/models/atendimento.dart';
import 'package:oficina_automotiva/models/pessoa.dart';
import 'package:oficina_automotiva/models/trabalho.dart';
import 'package:oficina_automotiva/models/veiculo.dart';

void main() {
  final pessoa = Pessoa(
      id: 1, nome: 'Maria', telefone: '45 99999-0000', email: 'maria@email.com');
  final veiculo = Veiculo(
      placa: 'abc1d23',
      modelo: 'Onix',
      marca: 'Chevrolet',
      ano: 2020,
      responsavel: pessoa);
  print(veiculo);

  final atendimento = Atendimento(id: 1, problema: 'Barulho na suspensão');

  // Regra: não pode concluir sem trabalhos
  try {
    atendimento.concluir();
  } on StateError catch (e) {
    print('Erro esperado: ${e.message}');
  }

  final troca = Trabalho(id: 1, descricao: 'Troca de amortecedor', valorPadrao: 350);
  atendimento.adicionarTrabalho(troca);
  atendimento.adicionarTrabalho(
      Trabalho(id: 2, descricao: 'Alinhamento', valorPadrao: 120));
  print('Total: ${atendimento.calcularTotal()}');

  // Reajuste de valor
  troca.alterarValor(400);
  print('Total reajustado: ${atendimento.calcularTotal()}');

  // toMap / fromMap
  final mapa = atendimento.toMap();
  final copia = Atendimento.fromMap(mapa);
  print(copia);

  // copyWith
  final outro = atendimento.copyWith(problema: 'Suspensão e freios');
  print(outro);

  atendimento.concluir();
  print(atendimento);
}