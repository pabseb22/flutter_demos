import 'package:flutter/material.dart';
import 'package:flutter_bdd_sqlite_ejm1/dominio/entidades/usuario.dart';
import 'package:flutter_bdd_sqlite_ejm1/dominio/repositorio/usuario_repositorio.dart';

class UsuarioProvider with ChangeNotifier {
  List<Usuario> _usuarios = [];

  List<Usuario> _favoritos = [];

  //Getter de listas

  List<Usuario> get usuarios => _usuarios;

  List<Usuario> get favoritos => _favoritos;

  // método agregar usuario

  void agregarUsuario(Usuario nuevo) {
    _usuarios.add(nuevo);

    notifyListeners();
  }

  void eliminarUsuario(Usuario nuevo) {
    _usuarios.remove(nuevo);

    notifyListeners();
  }

  // Instancia del repositorio para manejar la base de datos

  final UsuarioRepositorio usuarioRepositorio = UsuarioRepositorio();

  // método para carcar de la base SQLite los datos favoritos guardados

  Future<void> cargarFavoritosDesdeBD() async {
    final data = await usuarioRepositorio.obtenerUsuarios();

    _favoritos = data;

    notifyListeners();
  }
}
