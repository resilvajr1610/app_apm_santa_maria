import 'package:app_apm_santa_maria/componentes/appbar_padrao.dart';
import 'package:app_apm_santa_maria/componentes/botao_camera.dart';
import 'package:app_apm_santa_maria/componentes/botao_texto.dart';
import 'package:app_apm_santa_maria/componentes/dropdown_padrao.dart';
import 'package:app_apm_santa_maria/componentes/snackBars.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/telas/tela_cadastrar_aluno.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:app_apm_santa_maria/uteis/dado_padrao.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import '../componentes/input_padrao.dart';

class TelaCadastrarSocio extends StatefulWidget {
  const TelaCadastrarSocio({super.key});

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
                                'nome': nome.text,
                                'cpf' : cpf.text,
                                'contato': telefone.text,
                                'rua'  : rua.text,
                                'numeroCasa' : numero.text,
                                'complemento' : complemento.text,
                                'bairro': bairro.text,
                                'cep' : cep.text,
                                'cidade' : cidade.text,
                                'estado' : estadoSelecionado,
                                'email' : email.text,
                                'senha' : senha.text,
                                'foto' : foto
                              };
                              print('ok');
                              //apenas avançar os dados para a próxima tela, só salvar quando tiver os dados de pelo menos um aluno
                              //e só será criado o usuario no auth depois que o acesso for aceito pelo sistema
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
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastrarAluno()));
  }

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarPadrao.appbar(context,'CADASTRO SÓCIO'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: ListView(
          children: [
            TextoPadrao(texto: 'Cadastro do sócio / responsável',cor: Cores.azul,tamanho: 14,negrito: true,),
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
                  list: DadoPadrao.estados,
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
            Divider(color: Cores.azul,),
            TextoPadrao(texto: 'Dados de Login',cor: Cores.azul,tamanho: 14,negrito: true,),
            InputPadrao(tituloTopo: 'E-mail', controller: email,paddingHorizontal: 0,paddingVertical: 5,textInputType: TextInputType.emailAddress,),
            InputPadrao(tituloTopo: 'Senha', controller: senha,paddingHorizontal: 0,paddingVertical: 5,ocultarTexto: true,),
            InputPadrao(tituloTopo: 'Confirmar Senha', controller: confirmarSenha,paddingHorizontal: 0,paddingVertical: 5,ocultarTexto: true,),
            BotaoCamera(funcao: ()=>pegarFoto(),foto: foto!=null?foto:null,),
            BotaoTexto(
              texto: 'Avançar',
              tamanhoTexto: 14,
              corBorda: Cores.azul,
              corBotao: Cores.azul,
              corTexto: Colors.white,
              tamanhoMaximo: Size(double.infinity,50),
              tamanhoMinimo: Size(double.infinity,50),
              funcao: ()=>verificarCampos(),
            )
          ],
        ),
      ),
    );
  }
}
