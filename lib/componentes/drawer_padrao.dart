import 'dart:async';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/modelos/bad_state_texto.dart';
import 'package:app_apm_santa_maria/telas/tela_empresas.dart';
import 'package:app_apm_santa_maria/telas/tela_emprestimos.dart';
import 'package:app_apm_santa_maria/telas/tela_conversas.dart';
import 'package:app_apm_santa_maria/telas/tela_estatuto_pdf.dart';
import 'package:app_apm_santa_maria/telas/tela_perfil.dart';
import 'package:app_apm_santa_maria/telas/tela_publicacoes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../telas/tela_login.dart';
import '../uteis/cores.dart';
import 'item_menu.dart';

class DrawerPadrao extends StatelessWidget {
  DocumentSnapshot? dadosUser;
  String? versao;
  DrawerPadrao({
    required this.dadosUser,
    this.versao,
  });

  Future<int> mensagens() async {
    final completer = Completer<int>();

    FirebaseFirestore.instance
        .collection('conversas')
        .where('idSocio', isEqualTo: dadosUser!['idUsuario'])
        .where('vistoSocio', isEqualTo: 'nao')
        .snapshots()
        .listen((docMensagens) {
      completer.complete(docMensagens.docs.length);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    List nomeCompleto = dadosUser == null ? [] : dadosUser!['nome'].toString().split(' ');
    String nome = nomeCompleto.isNotEmpty ? nomeCompleto[0] : '';

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          width: largura * 0.7,
          height: altura * 0.8,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Cores.azul,
                maxRadius: 35,
                child: CircleAvatar(
                  backgroundColor: Cores.input,
                  maxRadius: 33,
                  backgroundImage: dadosUser == null || BadStateTexto(dadosUser!,'foto')==''? null : NetworkImage(dadosUser!['foto']),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextoPadrao(
                  texto: 'Bem-vindo, $nome',
                  cor: Cores.azul,
                  tamanho: 14,
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(color: Cores.azul, indent: 50, endIndent: 50, thickness: 2),
              ItemMenu(
                titulo: 'Estatuto da APM',
                icone: Icons.book,
                funcao: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaEstatutoPDF())),
              ),
              ItemMenu(
                titulo: 'Publicações',
                icone: Icons.school,
                funcao: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TelaPublicacoes()),
                ),
              ),
              ItemMenu(
                titulo: 'Empréstimos',
                icone: Icons.handshake,
                funcao: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TelaEmprestimos()),
                ),
              ),
              ItemMenu(
                titulo: 'Empresas Conveniadas',
                icone: Icons.business,
                funcao: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaEmpresas(dadosUser: dadosUser,)),
                ),
              ),
              Row(
                children: [
                  ItemMenu(
                    titulo: 'Mensagens',
                    icone: Icons.message,
                    funcao: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TelaConversas()),
                    ),
                  ),
                  FutureBuilder<int>(
                    future: mensagens(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Enquanto carrega
                      }

                      if (!snapshot.hasData || snapshot.data == 0) {
                        return Container(); // Sem mensagens novas
                      }

                      // Exibir a quantidade de mensagens
                      return CircleAvatar(
                        backgroundColor: Cores.vermelho,
                        maxRadius: 10,
                        child: TextoPadrao(
                          texto: snapshot.data.toString(),
                          tamanho: 14,
                        ),
                      );
                    },
                  ),
                ],
              ),
              ItemMenu(
                titulo: 'Perfil',
                icone: Icons.person,
                funcao: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TelaPerfil()),
                ),
              ),
              const Spacer(),
              versao==null?Container():TextoPadrao(texto: 'versão $versao',cor: Cores.azul,tamanho: 14,),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TelaLogin()),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextoPadrao(
                        texto: 'Sair',
                        tamanho: 14,
                        cor: Cores.azul,
                      ),
                      const Icon(Icons.logout, color: Cores.azul),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
