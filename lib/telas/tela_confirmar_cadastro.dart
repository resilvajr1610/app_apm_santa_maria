import 'dart:io';
import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/componentes/titulo_texto.dart';
import 'package:app_apm_santa_maria/modelos/bad_state_texto.dart';
import 'package:app_apm_santa_maria/telas/tela_cadastrar_aluno.dart';
import 'package:app_apm_santa_maria/telas/tela_termo_adesao.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';

class TelaConfirmarCadastro extends StatefulWidget {
  Map <String,dynamic> dadosSocio;
  List<Map<String,dynamic>> alunosAdicionados;

  TelaConfirmarCadastro({
    required this.dadosSocio,
    required this.alunosAdicionados,
  });

  @override
  State<TelaConfirmarCadastro> createState() => _TelaConfirmarCadastroState();
}

class _TelaConfirmarCadastroState extends State<TelaConfirmarCadastro> {

  String? sexoSelecionado;
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
              child: widget.alunosAdicionados.isEmpty?Container():CircleAvatar(
                backgroundColor: Cores.input,
                maxRadius: 30,
                child: ClipOval(
                  child: widget.dadosSocio['foto'] != null
                      ? Image.file(
                    File(widget.dadosSocio['foto'].path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                      : Icon(
                    Icons.person, // Ícone padrão caso a foto seja nula
                    size: 30,
                  ),
                ),
              )
            ),
            TituloTexto(titulo: 'Nome', texto: widget.dadosSocio['nome']),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TituloTexto(titulo: 'CPF', texto: widget.dadosSocio['cpf']),
                Container(
                  width: largura*0.4,
                  child: TituloTexto(titulo: 'Telefone', texto: widget.dadosSocio['contato'])
                ),
              ],
            ),
            TituloTexto(
                maxLinhas: 3,
                titulo: 'Endereço',
                texto: '${widget.dadosSocio['rua']}, nº ${widget.dadosSocio['numeroCasa']}, ${widget.dadosSocio['bairro']}, ${widget.dadosSocio['cidade']}'
            ),
            Divider(color: Cores.azul,),
            TextoPadrao(texto: 'Aluno',cor: Cores.azul,tamanho: 14,negrito: true,),
            Container(
              height: widget.alunosAdicionados.length*220,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.alunosAdicionados.length,
                itemBuilder: (context,i){
                  return   Column(
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Cores.input,
                            maxRadius: 30,
                            child: ClipOval(child: Image.file(File(widget.alunosAdicionados[i]['foto']!.path),width: 100,height: 100,fit: BoxFit.cover,)),
                          )
                      ),
                      TituloTexto(titulo: 'Nome', texto: widget.alunosAdicionados[i]['nome']),
                      TituloTexto(titulo: 'Nome de guerra', texto: widget.alunosAdicionados[i]['nomeGuerra']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TituloTexto(titulo: 'Matrícula', texto: widget.alunosAdicionados[i]['matricula']),
                          Container(
                              width: largura*0.4,
                              child: TituloTexto(titulo: 'Nascimento', texto: widget.alunosAdicionados[i]['nascimento'])
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TituloTexto(titulo: 'Ano/série', texto: widget.alunosAdicionados[i]['serie']),
                          Container(
                              width: largura*0.4,
                              child: TituloTexto(titulo: 'Sexo', texto: widget.alunosAdicionados[i]['sexo'])
                          ),
                        ],
                      ),
                    ],
                  );
                }
              ),
            ),
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
                funcao: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                    TelaCadastrarAluno(dadosSocio: widget.dadosSocio,alunosAdicionados: widget.alunosAdicionados,))),
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
              funcao: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                  TelaTermoAdesao(alunosAdicionados: widget.alunosAdicionados,dadosSocio: widget.dadosSocio!,))),
            )
          ],
        ),
      ),
    );
  }
}
