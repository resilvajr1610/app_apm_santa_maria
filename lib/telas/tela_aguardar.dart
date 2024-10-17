import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';

class TelaAguardar extends StatefulWidget {
  const TelaAguardar({super.key});

  @override
  State<TelaAguardar> createState() => _TelaAguardarState();
}

class _TelaAguardarState extends State<TelaAguardar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 10,
            margin: EdgeInsets.all(50),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Cores.azul,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              alignment: Alignment.center,
              child: TextoPadrao(
                texto: 'Cadastro realizado com sucesso!\n'
                       'Aguarde a validação que será enviada no seu WhatsApp',tamanho: 20,negrito: true,textAlign: TextAlign.center,maxLinhas: 6,),
            ),
          ),
        ],
      ),
    );
  }
}
