import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseSqlite {
   //Tipo static permite acceder a _instance sin crear una nueva instancia de DataBaseSqlite.
  static final DataBaseSqlite instancia = DataBaseSqlite._internal();
  static Database? basedatos;

//factory devuelve la única instancia de DataBaseSqlite, Si llamas varias veces a DataBaseSqlite(), obtendrás siempre la misma instancia
  factory DataBaseSqlite() => instancia;
  DataBaseSqlite._internal(); //_internal() es un constructor privado (va de la mano con factory - patron singleton) que evita que otras clases creen instancias de DataBaseSqlite directamente.

 // Getter para Obtener la Base de Datos
  Future<Database> get database async {
    if (basedatos != null) return basedatos!;
    basedatos = await _initDB();
    return basedatos!;
  }
//Abrir o Inicializar la Base de Datos:
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'usuarios1.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE usuarios (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          email TEXT
        )
      ''');
    });
  }
}


