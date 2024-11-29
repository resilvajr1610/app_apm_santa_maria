import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/telas/tela_aguardar.dart';
import 'package:app_apm_santa_maria/telas/tela_perfil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../componentes/botao_texto.dart';
import '../uteis/cores.dart';

class TelaTermoAdesao extends StatefulWidget {
  Map<String,dynamic> dadosSocio;
  List<Map<String,dynamic>> alunosAdicionados;

  TelaTermoAdesao({
    required this.dadosSocio,
    required this.alunosAdicionados,
  });

  @override
  State<TelaTermoAdesao> createState() => _TelaTermoAdesaoState();
}

class _TelaTermoAdesaoState extends State<TelaTermoAdesao> {

  salvarDados()async{

    List ids = [];

    if(widget.dadosSocio['foto'] is! String && widget.dadosSocio['foto']!=null){
      Reference storageReference = FirebaseStorage.instance.ref().child('socios/${widget.dadosSocio['cpf'].toString().replaceAll('.', '').replaceAll('-', '')}_${DateTime.now().toIso8601String()+ ".jpg"}');
      Uint8List archive = await widget.dadosSocio['foto'].readAsBytes();
      UploadTask uploadTask = storageReference.putData(archive);

      uploadTask.then((caminho) {
        caminho.ref.getDownloadURL().then((link) {
          String linkfoto = link.toString();

          print('linkfoto');
          print(linkfoto);
          widget.dadosSocio['foto'] = linkfoto;
        });
      });
    }

    for(int i=0; widget.alunosAdicionados.length > i; i++){
      if(widget.alunosAdicionados[i]['foto'] is! String){
        Reference storageReference = FirebaseStorage.instance.ref().child('alunos/${DateTime.now().toIso8601String()+ ".jpg"}');
        Uint8List archive = await widget.alunosAdicionados[i]['foto'].readAsBytes();
        UploadTask uploadTask = storageReference.putData(archive);

        uploadTask.then((caminho) {
          caminho.ref.getDownloadURL().then((link)async {
            String linkfoto = link.toString();

            print('linkfoto');
            print(linkfoto);
            widget.alunosAdicionados[i]['foto'] = linkfoto;

            if(i+1==widget.alunosAdicionados.length){
              String? token = await FirebaseMessaging.instance.getToken();
              print(widget.dadosSocio);
              if(widget.dadosSocio['perfil']==''){
                final docRef = FirebaseFirestore.instance.collection('aprovacao').doc();
                FirebaseFirestore.instance.collection('aprovacao').doc(docRef.id).set({
                  'id' : docRef.id,
                  'situacao' : 'aguardando',
                  'dadosSocio' : widget.dadosSocio,
                  'alunosAdicionados' : widget.alunosAdicionados,
                  'token' : token
                }).then((_){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaAguardar()));
                });
              }else{
                for(int i = 0; widget.alunosAdicionados.length > i; i++){
                  final docRefAlunos = FirebaseFirestore.instance.collection('alunos').doc();
                  ids.add(docRefAlunos.id);
                  FirebaseFirestore.instance.collection('alunos').doc(docRefAlunos.id).set({
                    'idAluno'           : docRefAlunos.id,
                    'foto'              : widget.alunosAdicionados[i]['foto'],
                    'idSerie'           : widget.alunosAdicionados[i]['idSerie'],
                    'serie'             : widget.alunosAdicionados[i]['serie'],
                    'matricula'         : widget.alunosAdicionados[i]['matricula'],
                    'nascimento'        : widget.alunosAdicionados[i]['nascimento'],
                    'nome'              : widget.alunosAdicionados[i]['nome'],
                    'nomeGuerra'        : widget.alunosAdicionados[i]['nomeGuerra'],
                    'religiao'          : widget.alunosAdicionados[i]['religiao'],
                    'sexo'              : widget.alunosAdicionados[i]['sexo'],
                    'responsavelCriacao': FirebaseAuth.instance.currentUser!.email,
                    'criado'            : DateTime.now(),
                  }).then((_){
                    if(widget.alunosAdicionados.length == i+1){
                      FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).update({'alunos':ids}).then((_){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaPerfil()));
                      });
                    }
                  });
                }
              }
            }
          });
        });
      }else{

      }

    }
  }

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
                funcao: ()=>salvarDados(),
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
              maxLinhas: 50,
              tamanho: 14,
              cor: Colors.black87,
              texto:
              '''       Aceito e acato as disposições contidas no Estatuto da Associação de Pais e Mestres (APM), do Colégio Militar de Santa Maria (CMSM), manifestando expressamente meu interesse no sentido de fazer parte do Quadro Social da APM/CMSM, na categoria de Associado Contribuinte, a qual será estabelecida após assinatura do presente Termo de Adesão e aceite por parte desta entidade.''',
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
