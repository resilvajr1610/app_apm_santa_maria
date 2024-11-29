import 'package:app_apm_santa_maria/componentes/drawer_padrao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class TelaEmpresas extends StatefulWidget {
  var dadosUser;

  TelaEmpresas({
    required this.dadosUser
});

  @override
  State<TelaEmpresas> createState() => _TelaEmpresasState();
}

class _TelaEmpresasState extends State<TelaEmpresas> {

  var pesquisaController = TextEditingController();
  List <EmpresaModelo> listaTodasEmpresas = [];
  List <EmpresaModelo> listaEmpresasFiltradas = [];
  List<PerfilModelo> ramos = [];
  PerfilModelo? ramoSelecionado;


  pesquisar(){

    listaEmpresasFiltradas.clear();
    if(pesquisaController.text.isNotEmpty){
      for(int i = 0; listaTodasEmpresas.length > i; i++){
        if(listaTodasEmpresas[i].nome.toLowerCase().contains(pesquisaController.text.toLowerCase())){
          listaEmpresasFiltradas.add(listaTodasEmpresas[i]);
        }
      }
      if(listaEmpresasFiltradas.isEmpty){
        showSnackBar(context, 'Nenhuma empresa/profissional encontrado', Colors.red);
      }
    }else{
      listaEmpresasFiltradas.addAll(listaTodasEmpresas);
    }
    setState(() {});
  }

  filtrarRamo(){
    listaEmpresasFiltradas.clear();
    if(ramoSelecionado!.nome=='Selecione'){
      listaEmpresasFiltradas.addAll(listaTodasEmpresas);
    }else{
      for(int i=0; listaTodasEmpresas.length > i; i++){
        print(listaTodasEmpresas[i].ramo.nome);
        if(listaTodasEmpresas[i].ramo.nome == ramoSelecionado!.nome){
          listaEmpresasFiltradas.add(listaTodasEmpresas[i]);
        }
      }
    }
    setState(() {});
  }

  launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchWhatsApp(String phone) async {

    String numero = '55'+phone.toString().replaceAll('(', '').replaceAll(')', '').replaceAll('-', '').replaceAll(' ', '');

    final Uri url = Uri.parse('https://wa.me/$numero?text=${Uri.encodeComponent('')}');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }


  carregarRamos()async{
    FirebaseFirestore.instance.collection('ramos').orderBy('nome').get().then((perfilDoc){
      ramos.clear();
      ramos.add(PerfilModelo(id: 'selecione', nome: 'Selecione'));
      perfilDoc.docs.forEach((valor){
        ramos.add(
            PerfilModelo(
                id: valor['id'],
                nome: valor['nome']
            )
        );
      });
      setState(() {});
      carregarEmpresas();
    });
  }

  carregarEmpresas()async{

    FirebaseFirestore.instance.collection('empresas').orderBy('nome').get().then((docEmpresas){
      listaTodasEmpresas.clear();
      listaEmpresasFiltradas.clear();
      for(int i = 0; i<docEmpresas.docs.length; i++){
        PerfilModelo ramo = ramos.firstWhere(
                (element) => element.id == docEmpresas.docs[i]['ramoId'],
            orElse: () => ramos[0]
        );
        listaTodasEmpresas.add(
            EmpresaModelo(
                id: docEmpresas.docs[i].id,
                nome: docEmpresas.docs[i]['nome'],
                ramo: ramo,
                whats: docEmpresas.docs[i]['telefone'],
                endereco: docEmpresas.docs[i]['endereco'],
                cidade: docEmpresas.docs[i]['cidade'],
                instagram: docEmpresas.docs[i]['instagram'],
                facebook: docEmpresas.docs[i]['facebook'],
                site: docEmpresas.docs[i]['site']
            )
        );
      }
      listaEmpresasFiltradas.addAll(listaTodasEmpresas);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    carregarRamos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(alignment:Alignment.centerRight,child: TextoPadrao(texto: 'APM',negrito: true,tamanho: 20,)),
        backgroundColor: Cores.azul,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Image.asset('assets/imagens/logo.png',height: 40,),
          SizedBox(width: 10,)
        ],
      ),
      drawer: DrawerPadrao(dadosUser: widget.dadosUser,),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 300,
                    height: 52,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Cores.azul)
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 250,
                          child: InputPadrao(
                            tituloTopo: '',
                            hint: 'Pesquisar',
                            paddingVertical: 0,
                            paddingHorizontal: 0,
                            corBorda: Cores.background,
                            corInput: Cores.background,
                            corHint: Cores.azul,
                            controller: pesquisaController,
                            onChanged: (valor){},
                            pesquisar: (valor){
                              pesquisar();
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search,color: Cores.azul,size: 20,),
                          onPressed: ()=>pesquisar(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                      width: 300,
                      child: DropdownPerfil(
                        tamanhoFonte: 12,
                        selecionado: ramoSelecionado,
                        titulo: '',
                        larguraLista: 300,
                        larguraItem: 250,
                        lista: ramos,
                        onChanged: (valor){
                          ramoSelecionado = valor;
                          filtrarRamo();
                        },
                      )
                  ),
                ],
              ),
            ),
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
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Cores.barraTabela,
                          borderRadius: BorderRadius.all(Radius.circular(0))
                      ),
                      child: Row(
                        children: [
                          Container(
                              width: 90,
                              margin: EdgeInsets.only(left: 5),
                              child: TextoPadrao(texto: 'Empresa\nProfissional',tamanho: 12,cor: Cores.azul,maxLinhas: 2,)
                          ),
                          Container(
                              width: 80,
                              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                              child: TextoPadrao(texto: 'Ramo de\n Atividade',tamanho: 12,cor: Cores.azul,maxLinhas: 2,)
                          ),
                          Container(
                              width: 90,
                              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                              child: TextoPadrao(texto: 'Endereço',tamanho: 12,cor: Cores.azul,)
                          ),
                          Container(
                              width: 130,
                              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                              child: TextoPadrao(texto: 'Contatos',tamanho: 12,cor: Cores.azul,textAlign: TextAlign.center,)
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            // color: Cores.tabela,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: ListView.builder(
                          itemCount: listaEmpresasFiltradas.length,
                          itemBuilder: (context,i){

                            return Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  // color: Cores.tabela,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: 90,
                                      margin: EdgeInsets.only(left: 5,top: 10),
                                      child: TextoPadrao(texto: listaEmpresasFiltradas[i].nome ,tamanho: 10,cor: Colors.black87,)
                                  ),
                                  Container(
                                      width: 80,
                                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                                      child: TextoPadrao(texto: listaEmpresasFiltradas[i].ramo.nome ,tamanho: 10,cor: Colors.black87,)
                                  ),
                                  Container(
                                      width: 90,
                                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                                      child: TextoPadrao(texto: listaEmpresasFiltradas[i].endereco ,tamanho: 10,cor: Colors.black87,)
                                  ),
                                  listaTodasEmpresas[i].instagram.isEmpty?Container():Container(
                                    width: 30,
                                    child: IconButton(
                                      style: IconButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          backgroundColor: Cores.azul,maximumSize: Size(30, 30),minimumSize:Size(30, 30) ),
                                      icon: Icon(FontAwesomeIcons.instagram,color: Colors.white,size: 15,),
                                      onPressed: ()=>launchURL(listaTodasEmpresas[i].instagram),
                                    ),
                                  ),
                                  listaTodasEmpresas[i].facebook.isEmpty?Container():Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2.5),
                                    width: 30,
                                    child: IconButton(
                                      style: IconButton.styleFrom(backgroundColor: Cores.azul,maximumSize: Size(30, 30),minimumSize:Size(30, 30) ),
                                      icon: Icon(FontAwesomeIcons.facebook,color: Colors.white,size: 15,),
                                      onPressed: ()=>launchURL(listaTodasEmpresas[i].facebook),
                                    ),
                                  ),
                                  listaTodasEmpresas[i].whats.isEmpty?Container():Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2.5),
                                    width: 30,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      style: IconButton.styleFrom(backgroundColor: Cores.azul,maximumSize: Size(30, 30),minimumSize:Size(30, 30) ),
                                      icon: Icon(FontAwesomeIcons.whatsapp,color: Colors.white,size: 15,),
                                      onPressed: ()=>launchWhatsApp(listaTodasEmpresas[i].whats),
                                    ),
                                  ),
                                  listaTodasEmpresas[i].site.isEmpty?Container():Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2.5),
                                    width: 30,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      style: IconButton.styleFrom(backgroundColor: Cores.azul,maximumSize: Size(30, 30),minimumSize:Size(30, 30) ),
                                      icon: Icon(FontAwesomeIcons.globe,color: Colors.white,size: 15,),
                                      onPressed: ()=>launchURL(listaTodasEmpresas[i].site),
                                    ),
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
