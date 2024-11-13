import 'package:app_apm_santa_maria/componentes/drawer_padrao.dart';
import 'package:app_apm_santa_maria/modelos/publicacao_modelo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../componentes/botao_texto.dart';
import '../componentes/dropdown_perfil.dart';
import '../componentes/input_padrao.dart';
import '../componentes/snackBars.dart';
import '../componentes/texto_padrao.dart';
import '../modelos/empresa_modelo.dart';
import '../modelos/perfil_modelo.dart';
import '../uteis/cores.dart';
import '../uteis/dados_padroes.dart';

class TelaPublicacoes extends StatefulWidget {

  @override
  State<TelaPublicacoes> createState() => _TelaPublicacoesState();
}

class _TelaPublicacoesState extends State<TelaPublicacoes> {

  List<PublicacaoModelo> publicacoes = [];
  var dadosUser;

  carregarPublicacoes()async{

    FirebaseFirestore.instance.collection('publicacoes').where('situacao',isEqualTo: 'liberado' ).orderBy('data',descending: true).snapshots().listen((docPubs){
      publicacoes.clear();
      for(int i =0; docPubs.docs.length > i; i++){
        publicacoes.add(
            PublicacaoModelo(
                id: docPubs.docs[i]['id'],
                data: DadosPadroes.formatarDataHora(docPubs.docs[i]['data']),
                timestamp: docPubs.docs[i]['data'],
                perfil: docPubs.docs[i]['perfil'],
                responsavelCriacao: docPubs.docs[i]['responsavelCriacao'],
                responsavelNome: docPubs.docs[i]['responsavelNome'],
                texto: docPubs.docs[i]['texto'],
                urlImagem: docPubs.docs[i]['urlImagem']
            )
        );
      }
      salvarVisualizacoes();
      setState(() {});
    });
  }

  Future<void> salvarVisualizacoes() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    for (var publicacao in publicacoes) {
      DocumentReference docRef = FirebaseFirestore.instance.collection('publicacoes').doc(publicacao.id);
      batch.update(docRef, {
        'visualizacao': FieldValue.arrayUnion([userId])
      });
    }

    try {
      await batch.commit();
    } catch (e) {
      print('Erro ao salvar visualizações: $e');
    }
  }


  carregarUsuario(){
    FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).get().then((docUser){
      dadosUser = docUser;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    carregarPublicacoes();
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                    // color: Cores.tabela,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            // color: Cores.tabela,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: ListView.builder(
                          itemCount: publicacoes.length,
                          itemBuilder: (context,i){

                            return Card(
                              color: Colors.grey[100],
                              margin: EdgeInsets.all(20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: largura*0.9,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              child: CircleAvatar(
                                                  minRadius: 20,
                                                  backgroundColor: Cores.azul,
                                                  child: Image.asset('assets/imagens/logo.png',height: 30,)
                                              ),
                                            ),
                                            Container(
                                              width: largura*0.4,
                                              child: TextoPadrao(texto: publicacoes[i].responsavelNome,cor: Colors.black87,tamanho: 14,),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: largura*0.3,
                                              child: TextoPadrao(texto: publicacoes[i].data,cor: Colors.black87,tamanho: 12,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Cores.input,
                                        padding: EdgeInsets.all(20),
                                        width: largura*0.8,
                                        child: TextoPadrao(texto: publicacoes[i].texto,cor: Colors.black87,maxLinhas: 0,tamanho: 16,textAlign: TextAlign.justify,),
                                      ),
                                      publicacoes[i].urlImagem==''?Container():Container(
                                        margin: EdgeInsets.all(20),
                                        child: CachedNetworkImage(
                                          alignment: Alignment.center,
                                          width: largura*0.8,
                                          height: 200,
                                          imageUrl: publicacoes[i].urlImagem,
                                          placeholder: (context, url) => Transform.scale(
                                              scale: 0.05,
                                              child: SizedBox(
                                                  width: 15,
                                                  height: 15,
                                                  child: CircularProgressIndicator())),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                      ),
                                      publicacoes[i].urlImagem==''?SizedBox(height: 40,):Container()
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
