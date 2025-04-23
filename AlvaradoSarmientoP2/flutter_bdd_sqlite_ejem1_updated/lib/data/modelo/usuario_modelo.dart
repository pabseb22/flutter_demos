// class UsuarioModel {
//   final int id;
//   final String nombre;
//   final String email;

//   UsuarioModel({required this.id, required this.nombre, required this.email});

//   factory UsuarioModel.fromMap(Map<String, dynamic> map) => UsuarioModel(
//         id: map['id'],
//         nombre: map['nombre'],
//         email: map['email'],
//       );

//   Map<String, dynamic> toMap() {
//     final map = <String, dynamic>{
//       'nombre': nombre,
//       'email': email,
//     };
//     if (id != 0) map['id'] = id;
//     return map;
//   }
// }


import 'package:flutter_bdd_sqlite_ejm1/dominio/entidades/usuario.dart';

class UsuarioModel extends Usuario {
  UsuarioModel({required super.id, required super.nombre, required super.email});


//Convierte un Map en un objeto UsuarioModel (utilizado en la pagina_principal).
  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'],
      nombre: map['nombre'],
      email: map['email'],
    );
  }
//Convierte un objeto UsuarioModel a un Map para insertarlo o actualizarlo en la base de datos.
Map<String, dynamic> toMap() {
  final map = <String, dynamic>{
    'nombre': nombre,
    'email': email,
  };

  // Solo agrega 'id' si es diferente de 0 o no nulo (este numero es creado por la base de datos para cada usuario)
  if (id != 0) { 
    map['id'] = id;
  }

  return map;
} 
}
