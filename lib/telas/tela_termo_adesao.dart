import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/telas/tela_aguardar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../componentes/botao_texto.dart';
import '../uteis/cores.dart';

class TelaTermoAdesao extends StatefulWidget {
  const TelaTermoAdesao({super.key});

  @override
  State<TelaTermoAdesao> createState() => _TelaTermoAdesaoState();
}

class _TelaTermoAdesaoState extends State<TelaTermoAdesao> {

  confirmarAceitar()async{
    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: TextoPadrao(texto: 'Aviso',cor: Cores.azul,textAlign: TextAlign.center,tamanho: 16,negrito: true,),
            content: TextoPadrao(texto: 'Deseja aceitar os termos?',cor: Colors.black87,tamanho: 14,),
            actions: [
              BotaoTexto(
                texto: 'Voltar',
                arredodamento: 5,
                tamanhoTexto: 14,
                corBorda: Colors.grey,
                corBotao: Colors.grey,
                corTexto: Colors.white,
                tamanhoMaximo: Size(double.infinity,50),
                tamanhoMinimo: Size(double.infinity,50),
                funcao: ()=>Navigator.pop(context),
              ),
              SizedBox(height: 10,),
              BotaoTexto(
                texto: 'Aceitar',
                arredodamento: 5,
                tamanhoTexto: 14,
                corBorda: Colors.green,
                corBotao: Colors.green,
                corTexto: Colors.white,
                tamanhoMaximo: Size(double.infinity,50),
                tamanhoMinimo: Size(double.infinity,50),
                funcao: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaAguardar())),
              ),
            ],
          );
        }
    );
  }

  confirmarRecusar()async{
    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: TextoPadrao(texto: 'Aviso',cor: Cores.azul,textAlign: TextAlign.center,tamanho: 16,negrito: true,),
            content: TextoPadrao(
              texto: 'Deseja recusar os termos?\n'
                                'Recusando os termos será impossibilitado de utilizar o app.',
              cor: Colors.black87,
              tamanho: 14,
            ),
            actions: [
              BotaoTexto(
                texto: 'Voltar',
                arredodamento: 5,
                tamanhoTexto: 14,
                corBorda: Colors.grey,
                corBotao: Colors.grey,
                corTexto: Colors.white,
                tamanhoMaximo: Size(double.infinity,50),
                tamanhoMinimo: Size(double.infinity,50),
                funcao: ()=>Navigator.pop(context),
              ),
              SizedBox(height: 10,),
              BotaoTexto(
                texto: 'Recusar e fechar o app',
                arredodamento: 5,
                tamanhoTexto: 14,
                corBorda: Colors.red,
                corBotao: Colors.red,
                corTexto: Colors.white,
                tamanhoMaximo: Size(double.infinity,50),
                tamanhoMinimo: Size(double.infinity,50),
                funcao: ()=>SystemNavigator.pop(),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPadrao.appbar(context, 'TERMO DE ADESÃO'),
      body: ListView(
        children: [
          Container(
            color: Cores.input,
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.all(17),
            child: TextoPadrao(
              tamanho: 14,
              cor: Colors.black87,
              texto:
              '''       Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
            child: BotaoTexto(
              texto: 'Aceitar',
              tamanhoTexto: 14,
              arredodamento: 5,
              corBorda: Cores.azul,
              corBotao: Cores.azul,
              corTexto: Colors.white,
              tamanhoMaximo: Size(double.infinity,50),
              tamanhoMinimo: Size(double.infinity,50),
              funcao: ()=>confirmarAceitar(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
            child: BotaoTexto(
              texto: 'Recusar',
              arredodamento: 5,
              tamanhoTexto: 14,
              corBorda: Colors.red,
              corBotao: Colors.red,
              corTexto: Colors.white,
              tamanhoMaximo: Size(double.infinity,50),
              tamanhoMinimo: Size(double.infinity,50),
              funcao: ()=>confirmarRecusar(),
            ),
          )
        ],
      ),
    );
  }
}
