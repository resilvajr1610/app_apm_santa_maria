import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/botao_camera.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto_customizado.dart';
import 'package:app_apm_santa_maria/componentes/dropdown_padrao.dart';
import 'package:app_apm_santa_maria/componentes/dropdown_series.dart';
import 'package:app_apm_santa_maria/componentes/snackBars.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/modelos/serie_modelo.dart';
import 'package:app_apm_santa_maria/telas/tela_confirmar_cadastro.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:image_picker/image_picker.dart';
import '../componentes/input_padrao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaCadastrarAluno extends StatefulWidget {
  Map <String, dynamic> dadosSocio;
  List<Map<String,dynamic>> alunosAdicionados;

  TelaCadastrarAluno({
    required this.dadosSocio,
    required this.alunosAdicionados,
  });

  @override
  State<TelaCadastrarAluno> createState() => _TelaCadastrarAlunoState();
}

class _TelaCadastrarAlunoState extends State<TelaCadastrarAluno> {

  String? sexoSelecionado;
  String? religiaoSelecionado;
  SerieModelo? anoSelecionado;

  TextEditingController nomeAluno = TextEditingController();
  TextEditingController nomeGuerra = TextEditingController();
  TextEditingController matricula = TextEditingController();
  TextEditingController nascimento = TextEditingController();
  List <SerieModelo> series = [];
  XFile? foto;
  Map <String,dynamic> dadosAlunoAtual = {};
  List<Map<String,dynamic>> alunosAdicionados = [];

  verificarAluno(){
    List nomeCompleto = nomeAluno.text.split(' ');
    if(nomeCompleto.length>1){
      if(nomeGuerra.text.isNotEmpty){
        if(matricula.text.isNotEmpty){
          if(nascimento.text.length==10){
            if(anoSelecionado!=null){
              if(sexoSelecionado!=null){
                if(religiaoSelecionado!=null){
                  if(foto!=null){
                    dadosAlunoAtual = {};
                    dadosAlunoAtual={
                      'nome': nomeAluno.text,
                      'nomeGuerra' : nomeGuerra.text,
                      'matricula': matricula.text,
                      'nascimento'  : nascimento.text,
                      'serie' : anoSelecionado!.nome,
                      'idSerie' : anoSelecionado!.id,
                      'sexo': sexoSelecionado,
                      'religiao' : religiaoSelecionado,
                      'foto' : foto,
                      'indice' : alunosAdicionados.length
                    };
                    alunosAdicionados.add(dadosAlunoAtual);

                    List<Map<String, dynamic>> repetido = alunosAdicionados
                        .map((aluno) => aluno['matricula']) // Mapeia para pegar os IDs
                        .toSet() // Converte para Set para remover duplicados
                        .map((matricula) => alunosAdicionados.firstWhere((aluno) => aluno['matricula'] == matricula)) // Recupera os alunos únicos
                        .toList(); // Converte de volta para List

                    alunosAdicionados = repetido;

                    print('ok');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        TelaConfirmarCadastro(dadosSocio: widget.dadosSocio,alunosAdicionados: alunosAdicionados,)));
                  }else{
                    showSnackBar(context, 'Adicione uma foto do aluno', Colors.red);
                  }
                }else{
                  showSnackBar(context, 'Selecione a religião do aluno', Colors.red);
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
          showSnackBar(context, 'Matrácula não está preenchida', Colors.red);
        }
      }else{
        showSnackBar(context, 'Nome de guerra não preenchido', Colors.red);
      }
    }else{
      showSnackBar(context, 'Nome está incompleto', Colors.red);
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

  @override
  void initState() {
    super.initState();
    carregarAlunos();
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
                  child: InputPadrao(tituloTopo: 'Matrícula', controller: matricula,paddingHorizontal: 0,paddingVertical: 5,)
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
                        titulo: 'Ano/Série',
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
            BotaoCamera(funcao: ()=>pegarFoto(),foto: foto!=null?foto:null,),
            BotaoTexto(
              texto: 'Avançar',
              tamanhoTexto: 14,
              corBorda: Cores.azul,
              corBotao: Cores.azul,
              corTexto: Colors.white,
              tamanhoMaximo: Size(double.infinity,50),
              tamanhoMinimo: Size(double.infinity,50),
              funcao: ()=>verificarAluno(),
            )
          ],
        ),
      ),
    );
  }
}
