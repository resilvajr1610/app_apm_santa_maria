import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:flutter/material.dart';

import '../uteis/cores.dart';

class AppBarPadrao{

  @override
  static PreferredSize appbar(BuildContext context,String titulo) {
    return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: TextoPadrao(texto: titulo,negrito: true,tamanho: 20,),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Cores.azul,
      ),
    );
  }
}
