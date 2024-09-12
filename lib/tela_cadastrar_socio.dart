import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';

class TelaCadastrarSocio extends StatefulWidget {
  const TelaCadastrarSocio({super.key});

  @override
  State<TelaCadastrarSocio> createState() => _TelaCadastrarSocioState();
}

class _TelaCadastrarSocioState extends State<TelaCadastrarSocio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Cores.azul,
        title: TextoPadrao(texto: 'CADASTRO SÓCIO',),
      ),
    );
  }
}
