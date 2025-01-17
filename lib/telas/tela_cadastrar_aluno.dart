import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/botao_camera.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto_customizado.dart';
import 'package:app_apm_santa_maria/componentes/dropdown_padrao.dart';
import 'package:app_apm_santa_maria/componentes/dropdown_series.dart';
import 'package:app_apm_santa_maria/componentes/snackBars.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/modelos/bad_state_lista.dart';
import 'package:app_apm_santa_maria/modelos/serie_modelo.dart';
import 'package:app_apm_santa_maria/telas/tela_confirmar_cadastro.dart';
import 'package:app_apm_santa_maria/telas/tela_perfil.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:image_picker/image_picker.dart';
import '../componentes/input_padrao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaCadastrarAluno extends StatefulWidget {
  Map <String, dynamic>? dadosSocio;
  var alunosAdicionados;
  bool adicionarAluno;

  TelaCadastrarAluno({
    required this.dadosSocio,
    required this.alunosAdicionados,
    required this.adicionarAluno
  });

  @override
  State<TelaCadastrarAluno> createState() => _TelaCadastrarAlunoState();
}

class _TelaCadastrarAlunoState extends State<TelaCadastrarAluno> {

  String? sexoSelecionado;
  SerieModelo? anoSelecionado;

  TextEditingController nomeAluno = TextEditingController();
  TextEditingController nomeGuerra = TextEditingController();
  TextEditingController numeroAluno = TextEditingController();
  TextEditingController nascimento = TextEditingController();
  List <SerieModelo> series = [];
  XFile? foto;
  Map <String,dynamic> dadosAlunoAtual = {};
  List<Map<String,dynamic>> alunosAdicionados = [];
  String fotoLink = '';

  verificarAluno(){
    List nomeCompleto = nomeAluno.text.split(' ');
    if(nomeCompleto.length>1){
      if(nomeGuerra.text.isNotEmpty){
        if(numeroAluno.text.length>3){
          if(nascimento.text.length==10){
            if(anoSelecionado!=null){
              if(sexoSelecionado!=null){
                if(foto!=null){
                  dadosAlunoAtual = {};
                  dadosAlunoAtual={
                    'nome': nomeAluno.text,
                    'nomeGuerra' : nomeGuerra.text,
                    'matricula': numeroAluno.text,
                    'nascimento'  : nascimento.text,
                    'serie' : anoSelecionado!.nome,
                    'idSerie' : anoSelecionado!.id,
                    'sexo': sexoSelecionado,
                    'foto' : foto,
                    'indice' : alunosAdicionados.length,
                    'anos' : [2024]
                  };
                  alunosAdicionados.add(dadosAlunoAtual);

                  List<Map<String, dynamic>> repetido = alunosAdicionados
                      .map((aluno) => aluno['matricula']) // Mapeia para pegar os IDs
                      .toSet() // Converte para Set para remover duplicados
                      .map((matricula) => alunosAdicionados.firstWhere((aluno) => aluno['matricula'] == matricula)) // Recupera os alunos únicos
                      .toList(); // Converte de volta para List

                  alunosAdicionados = repetido;

                  print('ok');
                  print('widget.dadosSocio');
                  print(widget.dadosSocio);
                  print('alunosAdicionados');
                  print(alunosAdicionados);

                  if(widget.adicionarAluno){
                    salvarAluno();
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        TelaConfirmarCadastro(dadosSocio: widget.dadosSocio!,alunosAdicionados: alunosAdicionados,)));
                  }
                }else{
                  showSnackBar(context, 'Adicione uma foto do aluno', Colors.red);
                }
              }else{
                showSnackBar(context, 'Selecione o sexo do aluno', Colors.red);
              }
            }else{
              showSnackBar(context, 'Selecione a turma do aluno', Colors.red);
            }
          }else{
            showSnackBar(context, 'Data de nascimento está incompleto', Colors.red);
          }
        }else{
          showSnackBar(context, 'Matrícula incorreta', Colors.red);
        }
      }else{
        showSnackBar(context, 'Nome de guerra não preenchido', Colors.red);
      }
    }else{
      showSnackBar(context, 'Nome está incompleto', Colors.red);
    }
  }

  verificarAlteracao(){
    List nomeCompleto = nomeAluno.text.split(' ');
    if(nomeCompleto.length>1){
      if(nomeGuerra.text.isNotEmpty){
        if(numeroAluno.text.length>3){
          if(nascimento.text.length==10){
            if(anoSelecionado!=null){
              if(sexoSelecionado!=null){
                if(foto!=null || fotoLink!=''){
                  print('ok');
                  salvarDados();
                }else{
                  showSnackBar(context, 'Adicione uma foto do aluno', Colors.red);
                }
              }else{
                showSnackBar(context, 'Selecione o sexo do aluno', Colors.red);
              }
            }else{
              showSnackBar(context, 'Selecione o ano série do aluno', Colors.red);
            }
          }else{
            showSnackBar(context, 'Data de nascimento está incompleto', Colors.red);
          }
        }else{
          showSnackBar(context, 'Matrícula incorreta', Colors.red);
        }
      }else{
        showSnackBar(context, 'Nome de guerra não preenchido', Colors.red);
      }
    }else{
      showSnackBar(context, 'Nome está incompleto', Colors.red);
    }
  }

  salvarDados()async{

    dadosAlunoAtual = {};
    dadosAlunoAtual={
      'nome': nomeAluno.text.toUpperCase(),
      'nomeGuerra' : nomeGuerra.text.toUpperCase(),
      'matricula': numeroAluno.text.toUpperCase(),
      'nascimento'  : nascimento.text.toUpperCase(),
      'serie' : anoSelecionado!.nome,
      'idSerie' : anoSelecionado!.id,
      'sexo': sexoSelecionado,
      'anos' : [2024]
    };
    if(foto!=null){
      Reference storageReference = FirebaseStorage.instance.ref().child('alunos/${DateTime.now().toIso8601String()+ ".jpg"}');
      Uint8List archive = await foto!.readAsBytes();
      UploadTask uploadTask = storageReference.putData(archive);

      uploadTask.then((caminho) {
        caminho.ref.getDownloadURL().then((link) {
          String linkfoto = link.toString();

          print('linkfoto');
          print(linkfoto);
          dadosAlunoAtual['foto'] = linkfoto;
          FirebaseFirestore.instance.collection('alunos').doc(widget.alunosAdicionados[0]['idAluno']).set(dadosAlunoAtual,SetOptions(merge: true)).then((_){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaPerfil()));
          });
        });
      });
    }else{
      FirebaseFirestore.instance.collection('alunos').doc(widget.alunosAdicionados[0]['idAluno']).set(dadosAlunoAtual,SetOptions(merge: true)).then((_){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaPerfil()));
      });
    }
  }

  carregarSeries(){
    FirebaseFirestore.instance.collection('series').orderBy('nome').get().then((seriesDoc){
      series.clear();
      for(int i = 0; seriesDoc.docs.length > i; i++){
        series.add(
            SerieModelo(
                id: seriesDoc.docs[i].id,
                nome: seriesDoc.docs[i]['nome']??'',
            )
        );
      }
      if(widget.dadosSocio==null){
        dadosAluno();
      }
      setState(() {});
    });
  }

  pegarFoto()async{
    try {
      var result = await await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
      setState(() {
        foto = result;
      });
    } on Exception {}
    if (!mounted) return;
  }

  carregarAlunos(){
    alunosAdicionados = widget.alunosAdicionados;
  }

  dadosAluno(){
    nomeAluno.text = widget.alunosAdicionados[0]['nome'];
    nomeGuerra.text = widget.alunosAdicionados[0]['nomeGuerra'];
    numeroAluno.text = widget.alunosAdicionados[0]['matricula'];
    nascimento.text = widget.alunosAdicionados[0]['nascimento'];
    anoSelecionado = series.firstWhere((serie) => serie.id == widget.alunosAdicionados[0]['idSerie']);
    sexoSelecionado = widget.alunosAdicionados[0]['sexo'];
    fotoLink = widget.alunosAdicionados[0]['foto'];
    setState(() {});
  }

  salvarAluno()async{
    Reference storageReference = FirebaseStorage.instance.ref().child('alunos/${DateTime.now().toIso8601String()+ ".jpg"}');
    Uint8List archive = await foto!.readAsBytes();
    UploadTask uploadTask = storageReference.putData(archive);

    uploadTask.then((caminho) {
      caminho.ref.getDownloadURL().then((link) {
        String linkfoto = link.toString();
        final docRefAlunos = FirebaseFirestore.instance.collection('alunos').doc();
        FirebaseFirestore.instance.collection('alunos').doc(docRefAlunos.id).set({
          'idAluno'             : docRefAlunos.id,
          'nome'                : nomeAluno.text.toUpperCase(),
          'nomeGuerra'          : nomeGuerra.text.toUpperCase(),
          'matricula'           : numeroAluno.text.toUpperCase(),
          'nascimento'          : nascimento.text.toUpperCase(),
          'serie'               : anoSelecionado!.nome,
          'idSerie'             : anoSelecionado!.id,
          'sexo'                : sexoSelecionado,
          'foto'                : linkfoto,
          'responsavelCriacao'  : FirebaseAuth.instance.currentUser!.email,
          'criado'              : DateTime.now(),
          'anos'                : FieldValue.arrayUnion([DateTime.now().year])
        },SetOptions(merge: true)).then((_){
          FirebaseFirestore.instance.collection('usuarios')
              .doc(FirebaseAuth.instance.currentUser!.uid).update({
            'alunos':FieldValue.arrayUnion([docRefAlunos.id]),
          }).then((_){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaPerfil()));
          });
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if(widget.dadosSocio!=null && widget.alunosAdicionados.length !=0){
      carregarAlunos();
    }
    carregarSeries();
  }

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
            InputPadrao(tituloTopo: 'Nome', controller: nomeAluno,paddingHorizontal: 0,paddingVertical: 5,),
            InputPadrao(tituloTopo: 'Nome de Guerra', controller: nomeGuerra,paddingHorizontal: 0,paddingVertical: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: largura*0.38,
                  child: InputPadrao(tituloTopo: 'Número do aluno', controller: numeroAluno,paddingHorizontal: 0,paddingVertical: 5,)
                ),
                Container(
                  width: largura*0.38,
                  child: InputPadrao(
                    tituloTopo: 'Nascimento',
                    controller: nascimento,
                    paddingHorizontal: 0,
                    paddingVertical: 5,
                    hint: '00/00/0000',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter()
                    ],
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
                  child: Container(
                      width: largura*0.38,
                      child: DropdownSeries(
                        titulo: 'Turma',
                        largura: largura*0.38,
                        lista: series,
                        selecionado: anoSelecionado,
                        tamanhoFonte: 14,
                        larguraContainer: largura*0.27,
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
            widget.dadosSocio==null && foto ==null?Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()=>pegarFoto(),
                child: fotoLink==''? Container(
                  height: 50,child: Icon(Icons.add_a_photo,color: Cores.azul,size: 30,),) :
                CircleAvatar(
                  backgroundColor: Cores.input,
                  maxRadius: 50,
                  backgroundImage: NetworkImage(fotoLink),
                ),
              ),
            ):BotaoCamera(funcao: ()=>pegarFoto(),foto: foto!=null?foto:null,),
            BotaoTexto(
              texto: widget.dadosSocio==null?'Salvar':'Avançar',
              tamanhoTexto: 14,
              corBorda: Cores.azul,
              corBotao: Cores.azul,
              corTexto: Colors.white,
              tamanhoMaximo: Size(double.infinity,50),
              tamanhoMinimo: Size(double.infinity,50),
              funcao: ()=>widget.dadosSocio==null?verificarAlteracao():verificarAluno(),
            )
          ],
        ),
      ),
    );
  }
}
