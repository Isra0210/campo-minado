import 'package:campo_minado/models/Campo.dart';
import 'package:flutter/material.dart';

class CampoWidget extends StatelessWidget {
  final Campo campo;
  final void Function(Campo) onAbrir;
  final void Function(Campo) onAlternarMarcacao;

  CampoWidget({
    @required this.campo,
    @required this.onAbrir,
    @required this.onAlternarMarcacao,
  });

  Widget _getImage() {
    int qntMinas = campo.qntMinasNaVizinhanca;
    if (campo.aberto && campo.minado && campo.explodido) {
      return Image.asset('lib/assets/bomba_0.jpeg');
    } else if (campo.aberto && campo.minado) {
      return Image.asset('lib/assets/bomba_1.jpeg');
    } else if (campo.aberto) {
      return Image.asset('lib/assets/aberto_$qntMinas.jpeg');
    } else if (campo.marcado) {
      return Image.asset('lib/assets/bandeira.jpeg');
    } else {
      return Image.asset('lib/assets/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAbrir(campo),
      onLongPress: () => onAlternarMarcacao(campo),
      child: _getImage(),
    );
  }
}
