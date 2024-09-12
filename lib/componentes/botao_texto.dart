import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:flutter/material.dart';

class BotaoTexto extends StatelessWidget {

  String texto;
  bool negrito;
  double tamanhoTexto;
  Color corBotao;
  Color corBorda;
  Color corTexto;
  var onPressed;
  Size tamanhoMaximo;
  Size tamanhoMinimo;
  double arredodamento;

  BotaoTexto({
    required this.texto,
    required this.corBotao,
    required this.corBorda,
    required this.corTexto,
    required this.onPressed,
    this.tamanhoMaximo = const Size(250, 100),
    this.tamanhoMinimo = const Size(250, 70),
    this.negrito = true,
    this.tamanhoTexto = 20,
    this.arredodamento = 10,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        maximumSize: tamanhoMaximo,
        minimumSize: tamanhoMinimo,
        backgroundColor: corBotao,
        side: BorderSide(
          color: corBorda,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(arredodamento), // Define o raio das bordas
        ),
      ),
      child: TextoPadrao(texto: texto,cor: corTexto,negrito: negrito,tamanho: tamanhoTexto,),
      onPressed: onPressed,
    );
  }
}
