import 'package:flutter/material.dart';
import 'package:flutter_bdd_sqlite_ejm1/data/modelo/usuario_modelo.dart';
import 'package:flutter_bdd_sqlite_ejm1/dominio/providers/UsuarioProvider.dart';
import 'package:flutter_bdd_sqlite_ejm1/dominio/repositorio/usuario_repositorio.dart';
import 'package:provider/provider.dart';

class EstudiantesPage extends StatefulWidget {
  const EstudiantesPage({super.key});
  @override
  State<EstudiantesPage> createState() => _EstudiantesPageState();
}

class _EstudiantesPageState extends State<EstudiantesPage> {
  //TextEditors para tomar los datos
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  //Se instancia de la clase UsuarioRepositorio para usar los metodos eliminar e insertar
  final UsuarioRepositorio usuarioRepositorio = UsuarioRepositorio();
  // metodo initState, se ejecuta a penas comienza la app
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                provider.agregarUsuario(UsuarioModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    nombre: nombreController.text,
                    email: emailController.text));

                nombreController.clear();
                emailController.clear();
              },
              child: const Text('Agregar Usuario'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: provider.usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = provider.usuarios[index];
                  var esFavorito =
                      provider.favoritos.any((u) => u.id == usuario.id);
                  var icon = esFavorito ? Icons.star : Icons.star_border;
                  return Card(
                    child: ListTile(
                        title: Text(usuario.nombre),
                        subtitle: Text(usuario.email),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  usuarioRepositorio
                                      .eliminarUsuario(usuario.id);
                                  provider.eliminarUsuario(usuario);
                                }),
                            IconButton(
                                icon: Icon(icon, color: Colors.orange),
                                onPressed: () {
                                  if (esFavorito) {
                                    usuarioRepositorio
                                        .eliminarUsuario(usuario.id);
                                    provider.cargarFavoritosDesdeBD();
                                  } else {
                                    usuarioRepositorio.insertarUsuario(
                                        UsuarioModel(
                                            id: usuario.id,
                                            nombre: usuario.nombre,
                                            email: usuario.email));
                                    provider.cargarFavoritosDesdeBD();
                                  }
                                }),
                          ],
                        )),
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
