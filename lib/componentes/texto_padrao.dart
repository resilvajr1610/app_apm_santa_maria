import 'package:flutter/material.dart';

class TextoPadrao extends StatelessWidget {

  String texto;
  Color cor;
  bool negrito;
  double tamanho;
  TextAlign textAlign;

  TextoPadrao({
    required this.texto,
    this.cor = Colors.white,
    this.tamanho = 24,
    this.negrito = false,
    this.textAlign = TextAlign.start
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Nunito',
        color: cor,
        fontWeight: negrito?FontWeight.bold:FontWeight.normal,
        fontSize: tamanho,
      ),
    );
  }
}
