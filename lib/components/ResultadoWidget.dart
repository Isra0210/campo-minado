import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool venceu;
  final Function onReiniciar;

  ResultadoWidget({
    @required this.venceu,
    @required this.onReiniciar,
  });

  Color _getColor() {
    if (venceu == null) {
      return Colors.yellow;
    } else if (venceu) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  IconData _getIcon() {
    if (venceu == null) {
      return Icons.sentiment_satisfied;
    } else if (venceu) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      //livra da parte do nor no caso do iphone
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10),
        child: Container(
          color: _getColor(),
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              _getIcon(),
              color: Colors.white,
              size: 35,
            ),
            onPressed: onReiniciar,
          ),
        ),
      ),
    ));
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
