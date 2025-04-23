import 'package:flutter_bdd_sqlite_ejm1/data/db/data_base.dart';
import 'package:flutter_bdd_sqlite_ejm1/data/modelo/usuario_modelo.dart';

class UsuarioRepositorio {
  // Insertar un usuario
  Future<void> insertarUsuario(UsuarioModel usuario) async {
    final db = await DataBaseSqlite.instancia.database;
    await db.insert('usuarios', usuario.toMap());
  }

  // Obtener todos los usuarios
  Future<List<UsuarioModel>> obtenerUsuarios() async {
    final db = await DataBaseSqlite.instancia.database;
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (i) {
      return UsuarioModel.fromMap(maps[i]);
    });
  }

  // Eliminar usuario por ID
  Future<void> eliminarUsuario(int id) async {
    final db = await DataBaseSqlite.instancia.database;
    await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }

}