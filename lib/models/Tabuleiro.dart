import 'dart:math';

import 'package:campo_minado/models/Campo.dart';
import 'package:flutter/foundation.dart';

class Tabuleiro {
  final int linha;
  final int coluna;
  final int qntBombas;

  List<Campo> _campos = [];

  Tabuleiro({
    @required this.linha,
    @required this.coluna,
    @required this.qntBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void reiniciar() {
    _campos.forEach((camp) => camp.reiniciar());
    _sortearMinas();
  }

  void revelarBombas(){
    _campos.forEach((camp) => camp.revelarBomba());
  }

  void _criarCampos() {
    for (int l = 0; l < linha; l++) {
      for (int c = 0; c < coluna; c++) {
        _campos.add(
          Campo(linha: l, coluna: c),
        );
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarvizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (qntBombas > linha * coluna) {
      return;
    }

    while (sorteadas < qntBombas) {
      int i = Random().nextInt(_campos.length);

      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  List<Campo> get campos {
    return _campos;
  }  

  bool get resolvido{
    return _campos.every((camp) => camp.resolvido);
  }
}
