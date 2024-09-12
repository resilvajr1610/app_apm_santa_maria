import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:flutter/material.dart';

import '../uteis/cores.dart';

class CheckPadrao extends StatelessWidget {

  bool check;
  String texto;
  var funcao;

  CheckPadrao({
    required this.check,
    required this.texto,
    required this.funcao,
  });

  @override
  Widget build(BuildContext context) {
    return   Container(
      child: Row(
        children: [
          Checkbox(
              value: check,
              activeColor: Cores.azul,
              onChanged: funcao
          ),
          TextoPadrao(texto: texto,cor: Cores.azul,tamanho: 12,),
        ],
      ),
    );
  }
}
