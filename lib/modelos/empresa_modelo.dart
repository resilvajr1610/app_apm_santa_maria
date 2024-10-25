import 'package:app_apm_santa_maria/modelos/perfil_modelo.dart';

class EmpresaModelo{
  String id;
  String nome;
  PerfilModelo ramo;
  String endereco;
  String cidade;
  String instagram;
  String facebook;
  String whats;
  String site;

  EmpresaModelo({
    required this.id,
    required this.nome,
    required this.ramo,
    required this.endereco,
    required this.cidade,
    required this.instagram,
    required this.facebook,
    required this.whats,
    required this.site,
  });
}