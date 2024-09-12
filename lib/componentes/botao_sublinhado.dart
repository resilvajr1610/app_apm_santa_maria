import 'package:flutter/material.dart';
import '../uteis/cores.dart';

class BotaoSublinhado extends StatelessWidget {
  String texto;
  var funcao;
  Color corTexto;
  Color corBotao;
  double larguraCustomizada;
  double borda;
  double altura;
  double paddingHorizontal;
  double paddingVertical;

  BotaoSublinhado({
    required this.texto,
    required this.funcao,
    this.corBotao = Cores.azul,
    this.corTexto = Colors.white,
    this.larguraCustomizada = 0.7,
    this.borda = 30.0,
    this.altura = 60.0,
    this.paddingHorizontal = 8,
    this.paddingVertical = 5
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical,horizontal: paddingHorizontal),
      child: TextButton(
          child: Text(texto,
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: funcao
      ),
    );
  }
}
