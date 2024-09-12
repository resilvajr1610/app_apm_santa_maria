import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/botao_camera.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto_customizado.dart';
import 'package:app_apm_santa_maria/componentes/dropdown_padrao.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/telas/tela_confirmar_cadastro.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';

import '../componentes/input_padrao.dart';

class TelaCadastrarAluno extends StatefulWidget {
  const TelaCadastrarAluno({super.key});

  @override
  State<TelaCadastrarAluno> createState() => _TelaCadastrarAlunoState();
}

class _TelaCadastrarAlunoState extends State<TelaCadastrarAluno> {

  String? sexoSelecionado;
  String? religiaoSelecionado;
  String? anoSelecionado;

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarPadrao.appbar(context,'CADASTRO ALUNO'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: ListView(
          children: [
            TextoPadrao(texto: 'Cadastro do aluno',cor: Cores.azul,tamanho: 14,negrito: true,),
            InputPadrao(tituloTopo: 'Nome', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,),
            InputPadrao(tituloTopo: 'Nome de Guerra', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: largura*0.38,
                  child: InputPadrao(tituloTopo: 'Matrícula', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,)
                ),
                Container(
                  width: largura*0.38,
                  child: InputPadrao(tituloTopo: 'Endereço', controller: TextEditingController(),paddingHorizontal: 0,paddingVertical: 5,)
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: largura*0.38,
                  child: Container(
                      width: largura*0.38,
                      child: DropDownPadrao(
                        title: 'Ano/Série',
                        width: largura*0.38,
                        list: ['5 A','5 B', '6 A', '6 B'],
                        select: anoSelecionado,
                        fontSize: 14,
                        widthContainer: largura*0.27,
                        onChanged: (valor){
                          anoSelecionado = valor;
                          setState(() {});
                        },
                      )
                  ),
                ),
                Container(
                  width: largura*0.38,
                  child: DropDownPadrao(
                    title: 'Sexo',
                    width: largura*0.38,
                    list: ['Masculino','Feminino'],
                    select: sexoSelecionado,
                    fontSize: 14,
                    widthContainer: largura*0.27,
                    onChanged: (valor){
                      sexoSelecionado = valor;
                      setState(() {});
                    },
                  )
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: largura*0.38,
                    child: DropDownPadrao(
                      title: 'Religião',
                      width: largura*0.38,
                      list: ['Católica','Evangélica','Não tem religião','Espírita','Outra','Ateu','Judaica'],
                      select: religiaoSelecionado,
                      fontSize: 14,
                      widthContainer: largura*0.27,
                      onChanged: (valor){
                        religiaoSelecionado = valor;
                        setState(() {});
                      },
                    )
                ),
                Container(
                  width: largura*0.38,
                ),
              ],
            ),
            BotaoCamera(),
            BotaoTexto(
              texto: 'Avançar',
              tamanhoTexto: 14,
              corBorda: Cores.azul,
              corBotao: Cores.azul,
              corTexto: Colors.white,
              tamanhoMaximo: Size(double.infinity,50),
              tamanhoMinimo: Size(double.infinity,50),
              funcao: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaConfirmarCadastro())),
            )
          ],
        ),
      ),
    );
  }
}
