import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "app_database.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    // Este método é chamado apenas na primeira vez que o banco é criado.
    // Ele cria todas as tabelas necessárias para a versão 1 do banco.
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        isCompleted INTEGER
      )
    ''');

    // Futuras tabelas seriam adicionadas aqui:
    // await db.execute('''
    //   CREATE TABLE academic_activities(...)
    // ''');
  }

  Future _onDowngrade(Database db, int oldVersion, int newVersion) async {
    await db.execute(''' 
      DROP TABLE IF EXISTS todos''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Este método é usado para migrações do banco de dados.
    // Por exemplo, se a versão for atualizada de 1 para 2.
    // if (oldVersion < 2) {
    //   await db.execute('ALTER TABLE todos ADD COLUMN new_column TEXT');
    // }
  }
}
