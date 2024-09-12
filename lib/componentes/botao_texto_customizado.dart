import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:flutter/material.dart';
import '../uteis/cores.dart';

class BotaoTextoCustomizado extends StatelessWidget {
  String texto;
  var funcao;
  Color corTexto;
  Color corBotao;
  double larguraCustomizada;
  double borda;
  double altura;
  double paddingHorizontal;
  double paddingVertical;

  BotaoTextoCustomizado({
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


    double largura = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical,horizontal: paddingHorizontal),
      child: TextButton(
          child: TextoPadrao(texto: texto,cor: corTexto,tamanho: 14,),
          style: TextButton.styleFrom(
              backgroundColor: corBotao,
              minimumSize: Size(largura*larguraCustomizada,altura),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(borda))
          ),
          onPressed: funcao
      ),
    );
  }
}
