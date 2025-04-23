import 'package:flutter/material.dart';
import 'package:flutter_bdd_sqlite_ejm1/data/modelo/usuario_modelo.dart';
import 'package:flutter_bdd_sqlite_ejm1/dominio/providers/UsuarioProvider.dart';
import 'package:flutter_bdd_sqlite_ejm1/dominio/repositorio/usuario_repositorio.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});
  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  List<UsuarioModel> usuarios = [];
  //TextEditors para tomar los datos
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  //Se instancia de la clase UsuarioRepositorio para usar los metodos eliminar e insertar
  final UsuarioRepositorio usuarioRepositorio = UsuarioRepositorio();
  // metodo initState, se ejecuta a penas comienza la app
  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  //Funcion para actualizar usuarios  (se utiliza en los botones eliminar y insertar)
  Future<void> _cargarUsuarios() async {
    final data = await usuarioRepositorio.obtenerUsuarios();
    setState(() {
      usuarios = data; // Actualiza la lista de usuarios
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios Favoritos - SQlite')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = usuarios[index];
                  return Card(
                    child: ListTile(
                      title: Text(usuario.nombre),
                      subtitle: Text(usuario.email),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            usuarioRepositorio.eliminarUsuario(usuario.id);
                            provider.cargarFavoritosDesdeBD();
                            _cargarUsuarios();
                          }),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
