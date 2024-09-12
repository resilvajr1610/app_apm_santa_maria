import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/botao_camera.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto_customizado.dart';
import 'package:app_apm_santa_maria/componentes/dropdown_padrao.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/componentes/titulo_texto.dart';
import 'package:app_apm_santa_maria/telas/tela_cadastrar_aluno.dart';
import 'package:app_apm_santa_maria/telas/tela_termo_adesao.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';

import '../componentes/input_padrao.dart';

class TelaConfirmarCadastro extends StatefulWidget {
  const TelaConfirmarCadastro({super.key});

  @override
  State<TelaConfirmarCadastro> createState() => _TelaConfirmarCadastroState();
}

class _TelaConfirmarCadastroState extends State<TelaConfirmarCadastro> {

  String? sexoSelecionado;
  String? religiaoSelecionado;
  String? anoSelecionado;

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarPadrao.appbar(context,'CONFIRMAR CADASTRO'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: ListView(
          children: [
            TextoPadrao(texto: 'Sócio',cor: Cores.azul,tamanho: 14,negrito: true,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.centerLeft,
              child: CircleAvatar(backgroundColor: Cores.input,maxRadius: 30,)
            ),
            TituloTexto(titulo: 'Nome', texto: 'Nome completo'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TituloTexto(titulo: 'CPF', texto: '000.000.000-00'),
                Container(
                  width: largura*0.4,
                  child: TituloTexto(titulo: 'Telefone', texto: '(00) 00000 - 0000')
                ),
              ],
            ),
            TituloTexto(titulo: 'Endereço', texto: 'Endereço completo, nº 1, bairro, cidade'),
            Divider(color: Cores.azul,),
            TextoPadrao(texto: 'Aluno',cor: Cores.azul,tamanho: 14,negrito: true,),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                child: CircleAvatar(backgroundColor: Cores.input,maxRadius: 30,)
            ),
            TituloTexto(titulo: 'Nome', texto: 'Nome completo'),
            TituloTexto(titulo: 'Nome de guerra', texto: 'Nome de guerra'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TituloTexto(titulo: 'Matrícula', texto: '000000'),
                Container(
                  width: largura*0.4,
                  child: TituloTexto(titulo: 'Nascimento', texto: '00/00/0000')
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TituloTexto(titulo: 'Ano/série', texto: '8º A'),
                Container(
                  width: largura*0.4,
                  child: TituloTexto(titulo: 'Sexo', texto: 'Masculino')
                ),
              ],
            ),
            TituloTexto(titulo: 'Religião', texto: 'Religião'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: BotaoTexto(
                texto: 'Adicinar novo aluno',
                tamanhoTexto: 14,
                arredodamento: 5,
                corBorda: Cores.azul,
                corBotao: Cores.azul,
                corTexto: Colors.white,
                tamanhoMaximo: Size(double.infinity,50),
                tamanhoMinimo: Size(double.infinity,50),
                funcao: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaCadastrarAluno())),
              ),
            ),
            BotaoTexto(
              texto: 'Avançar',
              arredodamento: 5,
              tamanhoTexto: 14,
              corBorda: Cores.azul,
              corBotao: Cores.azul,
              corTexto: Colors.white,
              tamanhoMaximo: Size(double.infinity,50),
              tamanhoMinimo: Size(double.infinity,50),
              funcao: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaTermoAdesao())),
            )
          ],
        ),
      ),
    );
  }
}
