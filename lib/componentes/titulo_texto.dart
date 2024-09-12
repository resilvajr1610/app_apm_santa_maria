import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:flutter/material.dart';
import '../uteis/cores.dart';

class TituloTexto extends StatelessWidget {

  String titulo;
  String texto;
  int maxLinhas;

  TituloTexto({
    required this.titulo,
    required this.texto,
    this.maxLinhas = 1
  });

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextoPadrao(texto: '$titulo: ',tamanho: 12,cor: Cores.azul,),
          Container(
            width: maxLinhas==1?null:largura*0.63,
             child: TextoPadrao(texto: texto,tamanho: 12,cor: Colors.black87,maxLinhas: maxLinhas,)
          ),
        ],
      ),
    );
  }
}
