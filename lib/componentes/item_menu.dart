import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:flutter/material.dart';

import '../uteis/cores.dart';

class ItemMenu extends StatelessWidget {

  String titulo;
  IconData icone;
  var funcao;

  ItemMenu({
    required this.titulo,
    required this.icone,
    required this.funcao,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          TextButton.icon(
            icon: Icon(icone,color: Cores.azul,),
            label: TextoPadrao(texto: titulo,tamanho: 14,cor: Cores.azul,),
            onPressed: funcao,
          )
        ],
      ),
    );
  }
}
