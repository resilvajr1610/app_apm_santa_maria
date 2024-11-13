import 'package:flutter/material.dart';

class TextoPadrao extends StatelessWidget {

  String texto;
  Color cor;
  bool negrito;
  double tamanho;
  TextAlign textAlign;
  int maxLinhas;

  TextoPadrao({
    required this.texto,
    this.cor = Colors.white,
    this.tamanho = 24,
    this.negrito = false,
    this.textAlign = TextAlign.start,
    this.maxLinhas = 1
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: textAlign,
      maxLines: maxLinhas ==0? null : maxLinhas,
      style: TextStyle(
        fontFamily: 'Nunito',
        color: cor,
        fontWeight: negrito?FontWeight.bold:FontWeight.normal,
        fontSize: tamanho,
      ),
    );
  }
}
