import 'package:app_apm_santa_maria/modelos/bad_state_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../componentes/botao_texto.dart';
import '../componentes/drawer_padrao.dart';
import '../componentes/input_padrao.dart';
import '../componentes/texto_padrao.dart';
import '../uteis/cores.dart';
import '../componentes/item_mensagem.dart';

class TelaMensagens extends StatefulWidget {
  String idConversa;

  TelaMensagens({
    required this.idConversa,
});

  @override
  State<TelaMensagens> createState() => _TelaMensagensState();
}

class _TelaMensagensState extends State<TelaMensagens> {

  List <ItemMensagem> mensagens=[];
  var inputMensagem = TextEditingController();
  DocumentSnapshot? dadosUser;

  void carregarMensagens() {
    FirebaseFirestore.instance
        .collection('mensagens')
        .where('idConversa', isEqualTo: widget.idConversa)
        .orderBy('envio', descending: true)
        .snapshots()
        .listen((querySnapshot) {
      mensagens.clear();

      for (var doc in querySnapshot.docs) {
        mensagens.add(
          ItemMensagem(
            mensagem: doc['mensagem'],
            data: formatarDataHora(doc['envio']),
            enviado: doc['enviado'],
            idFunc: doc['idFunc'],
            nomeFunc: doc['nomeFunc'],
            perfilFunc: BadStateString(doc, 'perfilFunc'),
            nomeSocio: doc['nomeSocio'],
            alunos: doc['alunos'],
          ),
        );
      }

      setState(() {}); // Atualiza a interface após carregar as mensagens
    });
  }


  String formatarDataHora(Timestamp timestamp) {
    DateTime data = timestamp.toDate();
    String dataFormatada = DateFormat('dd/MM/yyyy HH:mm').format(data);
    return dataFormatada;
  }

  salvarConversaMensagem()async{
    FirebaseFirestore.instance.collection('conversas').doc(widget.idConversa).set({
      'mensagem'        : inputMensagem.text,
      'vistoFunc'       : 'nao',
      'vistoSocio'      : 'sim',
      'envio'           : DateTime.now()
    },SetOptions(merge: true)).then((_){
      final docRef = FirebaseFirestore.instance.collection('mensagens').doc();
      FirebaseFirestore.instance.collection('mensagens').doc(docRef.id).set({
        'idMensagem'      : docRef.id,
        'idConversa'      : widget.idConversa,
        'idSocio'         : FirebaseAuth.instance.currentUser!.uid,
        'nomeSocio'       : mensagens[0].nomeSocio,
        'fotoSocio'       : dadosUser!['foto'],
        'contatoSocio'    : dadosUser!['contato'],
        'idFunc'          : mensagens[0].idFunc,
        'nomeFunc'        : mensagens[0].nomeFunc,
        'perfiFunc'       : mensagens[0].perfilFunc,
        'mensagem'        : inputMensagem.text,
        'alunos'          : mensagens[0].alunos,
        'vistoFunc'       : 'nao',
        'vistoSocio'      : 'sim',
        'enviado'         : FirebaseAuth.instance.currentUser!.uid,
        'envio'           : DateTime.now()
      }).then((_){
        inputMensagem.clear();
        setState(() {});
        carregarMensagens();
      });
    });
  }

  carregarUsuario()async{
    FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).get().then((docUser){
      dadosUser = docUser;
      setState(() {});
    });
  }

  atualizarVisto()async{
    FirebaseFirestore.instance.collection('conversas').doc(widget.idConversa).update({
          'vistoSocio':'sim',
          'vistoSocioData' : DateTime.now()
    });
  }
  
  @override
  void initState() {
    carregarMensagens();
    carregarUsuario();
    atualizarVisto();
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: TextoPadrao(texto: 'APM', negrito: true, tamanho: 20),
        ),
        backgroundColor: Cores.azul,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Image.asset('assets/imagens/logo.png', height: 50),
          SizedBox(width: 10),
        ],
      ),
      drawer: DrawerPadrao(dadosUser: dadosUser,),
      body: Container(
        height: altura*0.9,
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            TextoPadrao(
              texto: 'Mensagens',
              cor: Cores.azul,
              tamanho: 14,
              negrito: true,
            ),
            mensagens.isEmpty?Container():Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextoPadrao(
                texto: '${mensagens[0].nomeFunc}',
                cor: Cores.azul,
                tamanho: 12,
                negrito: true,
              ),
            ),
            Container(
              height: altura * 0.7,
              child: ListView.builder(
                reverse: true,
                itemCount: mensagens.length,
                itemBuilder: (context, i) {
                  return mensagens[i];
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Cores.input,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InputPadrao(
                      arredondamentoDireito: 0,
                      arredondamentoEsquerdo: 10,
                      tituloTopo: '',
                      controller: inputMensagem,
                      corBorda: Cores.input,
                      paddingHorizontal: 0,
                      paddingVertical: 0,
                      hint: 'Digite a sua mensagem',
                      onChanged: (texto){
                        setState(() {});
                      },
                    ),
                  ),
                  inputMensagem.text.isEmpty?Container():BotaoTexto(
                    tamanhoMaximo: Size(100, 35),
                    tamanhoMinimo: Size(100, 35),
                    arredodamento: 5,
                    texto: 'Enviar',
                    corBotao: Cores.azul,
                    corBorda: Cores.azul,
                    corTexto: Colors.white,
                    negrito: false,
                    tamanhoTexto: 14,
                    funcao: ()=>salvarConversaMensagem(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
