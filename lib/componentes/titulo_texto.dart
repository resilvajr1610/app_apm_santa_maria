import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:flutter/material.dart';
import '../uteis/cores.dart';

class TituloTexto extends StatelessWidget {

  String titulo;
  String texto;

  TituloTexto({
    required this.titulo,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          TextoPadrao(texto: '$titulo: ',tamanho: 12,cor: Cores.azul,),
          TextoPadrao(texto: texto,tamanho: 12,cor: Colors.black87,),
        ],
      ),
    );
  }
}
