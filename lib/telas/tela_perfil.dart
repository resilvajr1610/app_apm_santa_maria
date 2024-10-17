import 'dart:io';

import 'package:app_apm_santa_maria/componentes/botao_texto_customizado.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../componentes/drawer_padrao.dart';
import '../componentes/texto_padrao.dart';
import '../componentes/titulo_texto.dart';
import '../uteis/cores.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {

  DocumentSnapshot? dadosUser;
  List<DocumentSnapshot> alunos = [];

  carregarUsuario()async{
    FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).get().then((docUser){
      dadosUser = docUser;
      if(dadosUser!['alunos'].isNotEmpty){
        carregarAlunos();
      }
      setState(() {});
    });
  }

  carregarAlunos()async{
      for(int i=0; dadosUser!['alunos'].length > i;i ++){
        FirebaseFirestore.instance.collection('alunos').doc(dadosUser!['alunos'][i]).get().then((docAluno){
          alunos.add(docAluno);
          setState(() {});
        });
      }
  }

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Container(alignment:Alignment.centerRight,child: TextoPadrao(texto: 'APM',negrito: true,tamanho: 20,)),
        backgroundColor: Cores.azul,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Image.asset('assets/imagens/logo.png',height: 50,),
          SizedBox(width: 10,)
        ],
      ),
      drawer: DrawerPadrao(dadosUser: dadosUser,),
      body: dadosUser==null?Container():Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            CircleAvatar(
              backgroundColor: Cores.azul,
              maxRadius: 35,
              child: CircleAvatar(
                backgroundColor: Cores.input,
                maxRadius: 33,
                backgroundImage:dadosUser==null?null: NetworkImage(dadosUser!['foto']),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextoPadrao(texto: dadosUser!['nome'],cor: Cores.azul,tamanho: 14,textAlign: TextAlign.center,negrito: true,),
            ),
            TextoPadrao(texto: 'CPF '+dadosUser!['cpf'],cor: Cores.azul,tamanho: 14,textAlign: TextAlign.center,negrito: true,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextoPadrao(texto: 'Telefone: ',cor: Cores.azul,tamanho: 12,textAlign: TextAlign.center),
                TextoPadrao(texto: dadosUser!['contato'],cor: Cores.texto,tamanho: 12,textAlign: TextAlign.center),
              ],
            ),Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextoPadrao(texto: 'Endereço:     ',cor: Cores.azul,tamanho: 12,textAlign: TextAlign.center),
                Container(
                  width: largura*0.6,
                  child: TextoPadrao(texto: '${dadosUser!['rua']}, n° ${dadosUser!['numeroCasa']}, ${dadosUser!['bairro']}, ${dadosUser!['cidade'].toString().toUpperCase()}, '
                      '${dadosUser!['estado']}, CEP ${dadosUser!['cep']}',cor: Cores.texto,tamanho: 12,textAlign: TextAlign.start,maxLinhas: 5,),
                ),
              ],
            ),
            Divider(color: Cores.azul,indent: 0,endIndent: 0,thickness: 2,),
            TextoPadrao(texto: 'Alunos:',cor: Cores.azul,tamanho: 14,negrito: true,),
            Container(
              height: alunos.length*165,
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: alunos.length,
                  separatorBuilder: (context,i){
                    return Divider(indent: 20,endIndent: 20,height: 50,);
                  },
                  itemBuilder: (context,i){
                    return Row(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            margin: EdgeInsets.only(right: 20),
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundColor: Cores.input,
                              maxRadius: 30,
                              child:CircleAvatar(
                                backgroundColor: Cores.input,
                                maxRadius: 33,
                                backgroundImage:dadosUser==null?null: NetworkImage(alunos[i]['foto']),
                              ),
                            )
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TituloTexto(titulo: 'Nome', texto: alunos[i]['nome']),
                            TituloTexto(titulo: 'Nome de guerra', texto: alunos[i]['nomeGuerra']),
                            Container(
                              width: largura*0.65,
                              child: Row(
                                children: [
                                  TituloTexto(titulo: 'Matrícula', texto: alunos[i]['matricula']),
                                  Spacer(),
                                  TituloTexto(titulo: 'Ano/série', texto:alunos[i]['serie']),
                                ],
                              ),
                            ),
                            Container(
                              width: largura*0.65,
                              child: Row(
                                children: [
                                  TituloTexto(titulo: 'Nascimento', texto: alunos[i]['nascimento']),
                                  Spacer(),
                                  TituloTexto(titulo: 'Sexo', texto: alunos[i]['sexo'])
                                ],
                              ),
                            ),
                            TituloTexto(titulo: 'Religião', texto: alunos[i]['religiao']),
                          ],
                        ),
                      ],
                    );
                  }
              ),
            ),
            BotaoTextoCustomizado(texto: 'Alterar meu cadastro', funcao: (){},borda: 5,),
            BotaoTextoCustomizado(texto: 'Alterar cadastro do aluno', funcao: (){},borda: 5,),
            BotaoTextoCustomizado(texto: 'Excluir conta', funcao: (){},borda: 5,corBotao: Cores.erro,),
          ],
        ),
      ),
    );
  }
}
