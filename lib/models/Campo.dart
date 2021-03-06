import 'package:flutter/foundation.dart';
import 'ExplosaoException.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({
    @required this.linha,
    @required this.coluna,
  });

  void adicionarvizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha)
        .abs(); //abs() absoluto não retorna numeros negativo
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }

    if(deltaLinha <= 1 && deltaColuna <= 1){
      vizinhos.add(vizinho);
    }
  }

  void abrir(){
    if(_aberto){
      return;
    }

    _aberto = true;

    if(_minado){
      _explodido = true;
      throw ExplosaoException();
    }
      if(vizinhancaSegura){//recursão para abrir os vizinhos não minado
        vizinhos.forEach((viz) => viz.abrir());
      }
  }
  void revelarBomba(){
    if(_minado){
      _aberto = true;
    }
  }

  void minar(){
    _minado = true;
  }

  void alternarMarcacao(){
    _marcado = !_marcado;
  }

  void reiniciar(){
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get minado{
    return _minado;
  }
  
  bool get explodido{
    return _explodido;
  }
 
  bool get aberto{
    return _aberto;
  }

  bool get marcado{
    return _marcado;
  }

  bool get resolvido {
    bool minadoEMarcado = minado && marcado;
    bool seguroEAberto = !minado && aberto;

    return minadoEMarcado || seguroEAberto;
  }

  bool get vizinhancaSegura {
    return vizinhos.every((viz) => !viz.minado);//todos os vizinhos não minado
  }

  int get qntMinasNaVizinhanca{//pegando a quantidade de minas na vizinnhança
    return vizinhos.where((viz) => viz.minado).length;
  }
}
