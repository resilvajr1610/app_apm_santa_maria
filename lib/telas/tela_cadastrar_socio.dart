import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/botao_camera.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto.dart';
import 'package:app_apm_santa_maria/componentes/dropdown_padrao.dart';
import 'package:app_apm_santa_maria/componentes/snackBars.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/modelos/bad_state_lista.dart';
import 'package:app_apm_santa_maria/modelos/bad_state_texto.dart';
import 'package:app_apm_santa_maria/telas/tela_cadastrar_aluno.dart';
import 'package:app_apm_santa_maria/telas/tela_perfil.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:app_apm_santa_maria/uteis/dados_padroes.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import '../componentes/input_padrao.dart';

class TelaCadastrarSocio extends StatefulWidget {
  DocumentSnapshot? dadosUser;

  TelaCadastrarSocio({
   required this.dadosUser
});

  @override
  State<TelaCadastrarSocio> createState() => _TelaCadastrarSocioState();
}

class _TelaCadastrarSocioState extends State<TelaCadastrarSocio> {

  var nome = TextEditingController();
  var cpf = TextEditingController();
  var telefone = TextEditingController();
  var rua = TextEditingController();
  var numero = TextEditingController();
  var bairro = TextEditingController();
  var complemento = TextEditingController();
  var cep = TextEditingController();
  var cidade = TextEditingController();
  var email = TextEditingController();
  var senha = TextEditingController();
  var confirmarSenha = TextEditingController();
  String fotoLink = '';
  XFile? foto;
  String? estadoSelecionado;
  Map <String,dynamic> dadosSocio = {};

  pegarFoto()async{
    try {
      var result = await await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
      setState(() {
        foto = result;
      });
    } on Exception {}
    if (!mounted) return;
  }

  verificarCampos(){

    if(nome.text.isNotEmpty && nome.text.trim().contains(' ')){
      if(GetUtils.isCpf(cpf.text)){
        if(telefone.text.isNotEmpty && telefone.text.length > 13){
          if(rua.text.isNotEmpty && rua.text.trim().contains(' ')){
            if(numero.text.isNotEmpty){
              if(bairro.text.isNotEmpty){
                if(cep.text.length == 10){
                  if(cidade.text.isNotEmpty){
                    if(estadoSelecionado!=null){
                      if(email.text.contains('@') && email.text.contains('.')){
                        if(senha.text == confirmarSenha.text){
                          if(senha.text.length>=5){
                            if(foto!=null){
                              dadosSocio={
                                'nome': nome.text.toUpperCase(),
                                'cpf' : cpf.text,
                                'contato': telefone.text,
                                'rua'  : rua.text.toUpperCase(),
                                'numeroCasa' : numero.text.toUpperCase(),
                                'complemento' : complemento.text.toUpperCase(),
                                'bairro': bairro.text.toUpperCase(),
                                'cep' : cep.text,
                                'cidade' : cidade.text.toUpperCase(),
                                'estado' : estadoSelecionado,
                                'email' : email.text,
                                'senha' : senha.text,
                                'foto' : foto,
                                'perfil' : widget.dadosUser==null?'':widget.dadosUser!['perfil'] != null? widget.dadosUser!['perfil']:''
                              };
                              print('ok');
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastrarAluno(dadosSocio: dadosSocio,alunosAdicionados: [],)));
                            }else{
                              showSnackBar(context, 'Escolha uma foto de perfil para avançar', Colors.red);
                            }
                          }else{
                            showSnackBar(context, 'Preencha no mínimo 5 caracteres para a senha', Colors.red);
                          }
                        }else{
                          showSnackBar(context, 'As senhas não são iguais', Colors.red);
                        }
                      }else{
                        showSnackBar(context, 'Preencha um e-mail válido para avançar', Colors.red);
                      }
                    }else{
                      showSnackBar(context, 'Selecione seu estado para avançar', Colors.red);
                    }
                  }else{
                    showSnackBar(context, 'Preencha a cidade para avançar', Colors.red);
                  }
                }else{
                  showSnackBar(context, 'Preencha o CEP da sua rua para avançar', Colors.red);
                }
              }
            }else{
              showSnackBar(context, 'Preencha o número da sua casa para avançar', Colors.red);
            }
          }else{
            showSnackBar(context, 'Preencha a rua para avançar', Colors.red);
          }
        }else{
          showSnackBar(context, 'Telefone inválido', Colors.red);
        }
      }else{
        showSnackBar(context, 'CPF inválido', Colors.red);
      }
    }else{
      showSnackBar(context, 'Preencha seu nome para avançar', Colors.red);
    }
  }

  verificarAlteracao(){
    if(nome.text.isNotEmpty && nome.text.trim().contains(' ')){
      if(GetUtils.isCpf(cpf.text)){
        if(telefone.text.isNotEmpty && telefone.text.length > 13){
          if(rua.text.isNotEmpty && rua.text.trim().contains(' ')){
            if(numero.text.isNotEmpty){
              if(bairro.text.isNotEmpty){
                if(cep.text.length == 10){
                  if(cidade.text.isNotEmpty){
                    if(estadoSelecionado!=null){
                      dadosSocio={
                        'nome': nome.text.toUpperCase(),
                        'cpf' : cpf.text.toUpperCase(),
                        'contato': telefone.text.toUpperCase(),
                        'rua'  : rua.text.toUpperCase(),
                        'numeroCasa' : numero.text.toUpperCase(),
                        'complemento' : complemento.text.toUpperCase(),
                        'bairro': bairro.text.toUpperCase(),
                        'cep' : cep.text.toUpperCase(),
                        'cidade' : cidade.text.toUpperCase(),
                        'estado' : estadoSelecionado,
                        'perfil' : widget.dadosUser!['perfil'] != null? widget.dadosUser!['perfil']:''
                      };
                      salvarDados();
                    }else{
                      showSnackBar(context, 'Selecione seu estado para avançar', Colors.red);
                    }
                  }else{
                    showSnackBar(context, 'Preencha a cidade para avançar', Colors.red);
                  }
                }else{
                  showSnackBar(context, 'Preencha o CEP da sua rua para avançar', Colors.red);
                }
              }
            }else{
              showSnackBar(context, 'Preencha o número da sua casa para avançar', Colors.red);
            }
          }else{
            showSnackBar(context, 'Preencha a rua para avançar', Colors.red);
          }
        }else{
          showSnackBar(context, 'Telefone inválido', Colors.red);
        }
      }else{
        showSnackBar(context, 'CPF inválido', Colors.red);
      }
    }else{
      showSnackBar(context, 'Preencha seu nome para avançar', Colors.red);
    }
  }

  preencherCampos(){
    nome.text = BadStateTexto(widget.dadosUser!,'nome');
    cpf.text = BadStateTexto(widget.dadosUser!,'cpf');
    telefone.text = BadStateTexto(widget.dadosUser!,'contato');
    rua.text = BadStateTexto(widget.dadosUser!,'rua');
    numero.text = BadStateTexto(widget.dadosUser!,'numeroCasa');
    bairro.text = BadStateTexto(widget.dadosUser!,'bairro');
    complemento.text = BadStateTexto(widget.dadosUser!,'complemento');
    cep.text = BadStateTexto(widget.dadosUser!,'cep');
    cidade.text = BadStateTexto(widget.dadosUser!,'cidade').toString().toUpperCase();
    estadoSelecionado = BadStateTexto(widget.dadosUser, 'estado')==''?null:widget.dadosUser!['estado'];
    fotoLink = BadStateTexto(widget.dadosUser!,'foto');
    setState(() {});
  }

  salvarDados()async{
    if(foto!=null){
      Reference storageReference = FirebaseStorage.instance.ref().child('socios/${cpf.text.replaceAll('.', '').replaceAll('-', '')}_${DateTime.now().toIso8601String()+ ".jpg"}');
      Uint8List archive = await foto!.readAsBytes();
      UploadTask uploadTask = storageReference.putData(archive);

      uploadTask.then((caminho) {
        caminho.ref.getDownloadURL().then((link) {
          String linkfoto = link.toString();

          print('linkfoto');
          print(linkfoto);
          dadosSocio['foto'] = linkfoto;
          FirebaseFirestore.instance.collection('usuarios').doc(widget.dadosUser!['idUsuario']).set(dadosSocio,SetOptions(merge: true)).then((_){
            if(BadStateLista(widget.dadosUser!,'alunos').isEmpty){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastrarAluno(dadosSocio: dadosSocio,alunosAdicionados: [],)));
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaPerfil()));
            }
          });
        });
      });
    }else{
      FirebaseFirestore.instance.collection('usuarios').doc(widget.dadosUser!['idUsuario']).set(dadosSocio,SetOptions(merge: true)).then((_){
        if(BadStateLista(widget.dadosUser!,'alunos').isEmpty){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastrarAluno(dadosSocio: dadosSocio,alunosAdicionados: [],)));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaPerfil()));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.dadosUser!=null){
      preencherCampos();
    }
  }

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarPadrao.appbar(context,widget.dadosUser==null?'CADASTRO SÓCIO':'ATUALIZAR CADASTRO'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: ListView(
          children: [
            TextoPadrao(texto: widget.dadosUser==null?'Cadastro do sócio / responsável':'',cor: Cores.azul,tamanho: 14,negrito: true,),
            InputPadrao(tituloTopo: 'Nome', controller: nome,paddingHorizontal: 0,paddingVertical: 5,),
            InputPadrao(
              tituloTopo: 'CPF',
              controller: cpf,
              paddingHorizontal: 0,
              paddingVertical: 5,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter()
              ],
            ),
            InputPadrao(
              tituloTopo: 'Telefone',
              controller: telefone,
              paddingHorizontal: 0,
              paddingVertical: 5,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter()
              ],
              textInputType: TextInputType.number,
            ),
            TextoPadrao(texto: 'Endereço completo',cor: Cores.azul,tamanho: 14,negrito: true,),
            InputPadrao(tituloTopo: '', controller: rua,hint: 'Rua',paddingHorizontal: 0,paddingVertical: 5,),
            Row(
              children: [
                Container(
                  width: 95,
                  child: InputPadrao(
                    tituloTopo: '',
                    controller: numero,
                    hint: 'N°',
                    paddingHorizontal: 0,
                    paddingVertical: 5,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  )
                ),
                Spacer(),
                Container(
                  width: largura*0.55,
                  child: InputPadrao(tituloTopo: '', controller: bairro,hint: 'Bairro',paddingHorizontal: 0,paddingVertical: 5,)
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: largura*0.39,
                  child: InputPadrao(tituloTopo: '', controller: complemento,hint: 'Complemento',paddingHorizontal: 0,paddingVertical: 5,)
                ),
                Spacer(),
                Container(
                  width: largura*0.39,
                  child: InputPadrao(
                    tituloTopo: '',
                    controller: cep,
                    hint: 'CEP',
                    paddingHorizontal: 0,
                    paddingVertical: 5,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter()
                    ],
                  )
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: largura*0.55,
                  child: InputPadrao(tituloTopo: '', controller: cidade,hint: 'Cidade',paddingHorizontal: 0,paddingVertical: 5,)
                ),
                Spacer(),
                DropDownPadrao(
                  width: largura*0.25,
                  title: '',
                  select: estadoSelecionado,
                  list: DadosPadroes.estados,
                  widthContainer: largura*0.1,
                  fontSize: 15,
                  hint: 'Estado',
                  onChanged: (valor){
                    estadoSelecionado = valor;
                    setState(() {});
                  },
                ),
              ],
            ),
            widget.dadosUser!=null?Container():Divider(color: Cores.azul,),
            widget.dadosUser!=null?Container():TextoPadrao(texto: 'Dados de Login',cor: Cores.azul,tamanho: 14,negrito: true,),
            widget.dadosUser!=null?Container():InputPadrao(tituloTopo: 'E-mail', controller: email,paddingHorizontal: 0,paddingVertical: 5,textInputType: TextInputType.emailAddress,),
            widget.dadosUser!=null?Container():InputPadrao(tituloTopo: 'Senha', controller: senha,paddingHorizontal: 0,paddingVertical: 5,ocultarTexto: true,),
            widget.dadosUser!=null?Container():InputPadrao(tituloTopo: 'Confirmar Senha', controller: confirmarSenha,paddingHorizontal: 0,paddingVertical: 5,ocultarTexto: true,),
            widget.dadosUser!=null && foto ==null?Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()=>pegarFoto(),
                child: CircleAvatar(
                  backgroundColor: Cores.input,
                  maxRadius: 50,
                  backgroundImage:fotoLink==''?null: NetworkImage(fotoLink),
                ),
              ),
            ):BotaoCamera(funcao: ()=>pegarFoto(),foto: foto!=null?foto:null,),
            BotaoTexto(
              texto: widget.dadosUser==null?'Salvar':'Avançar',
              tamanhoTexto: 14,
              corBorda: Cores.azul,
              corBotao: Cores.azul,
              corTexto: Colors.white,
              tamanhoMaximo: Size(double.infinity,50),
              tamanhoMinimo: Size(double.infinity,50),
              funcao: ()=>widget.dadosUser==null?verificarCampos():verificarAlteracao(),
            )
          ],
        ),
      ),
    );
  }
}
