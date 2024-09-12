import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/botao_camera.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/telas/tela_cadastrar_aluno.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';
import '../componentes/input_padrao.dart';

class TelaCadastrarSocio extends StatefulWidget {
  const TelaCadastrarSocio({super.key});

  @override
  State<TelaCadastrarSocio> createState() => _TelaCadastrarSocioState();
}

class _TelaCadastrarSocioState extends State<TelaCadastrarSocio> {
  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarPadrao.appbar(context,'CADASTRO SÓCIO'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: ListView(
          children: [
            TextoPadrao(texto: 'Cadastro do sócio / responsável',cor: Cores.azul,tamanho: 14,negrito: true,),
            InputPadrao(tituloTopo: 'Nome', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,),
            InputPadrao(tituloTopo: 'CPF', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,),
            InputPadrao(tituloTopo: 'Telefone', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,),
            InputPadrao(tituloTopo: 'Endereço', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,),
            Divider(color: Cores.azul,),
            TextoPadrao(texto: 'Dados de Login',cor: Cores.azul,tamanho: 14,negrito: true,),
            InputPadrao(tituloTopo: 'E-mail', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,),
            InputPadrao(tituloTopo: 'Senha', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,),
            InputPadrao(tituloTopo: 'Confirmar Senha', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,),
            BotaoCamera(),
            BotaoTexto(
              texto: 'Avançar',
              tamanhoTexto: 14,
              corBorda: Cores.azul,
              corBotao: Cores.azul,
              corTexto: Colors.white,
              tamanhoMaximo: Size(double.infinity,50),
              tamanhoMinimo: Size(double.infinity,50),
              funcao: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastrarAluno())),
            )
          ],
        ),
      ),
    );
  }
}
