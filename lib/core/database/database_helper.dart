import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
    static final DatabaseHelper _instance = DatabaseHelper._internal();
    static Database? _database;

    factory DatabaseHelper() {
        return _instance;
    }

    DatabaseHelper._internal();

    Future<Database> get database async {
        if (_database != null) return _database!;
        _database = await _initDatabase();
        return _database!;
    }

    Future<Database> _initDatabase() async {
        String path = join(await getDatabasesPath(), 'sidekick.db');
        return await openDatabase(
            path,
            version: 1,
            onCreate: _onCreate,
        );
    }

    // Aquí creamos nuestra primera tabla: las tareas
    Future<void> _onCreate(Database db, int version) async {
        await db.execute(
            '''
            CREATE TABLE tareas(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                titulo TEXT,
                etiqueta TEXT,
                completada INTEGER DEFAULT 0
            )
            '''
        );
        
        // ¡La Inyección! Insertamos una tarea de prueba en cuanto nace la base de datos
        await db.insert('tareas', {
            'titulo': 'Dominar Flutter y SQLite',
            'etiqueta': '#Sidekick',
            'completada': 0
        });
    }

    // Método para obtener la primera tarea que no esté completada
    Future<Map<String, dynamic>?> obtenerPrimeraTarea() async {
        Database db = await database;
        List<Map<String, dynamic>> resultados = await db.query(
            'tareas',
            where: 'completada = ?',
            whereArgs: [0],
            limit: 1, //solo traemos una, respetando el "Modo foco"
        );

        if (resultados.isNotEmpty) {
            return resultados.first;
        }
        return null;
    }

    // Método para marcar la tarea como finalizada
    Future<int> marcarCompletada(int id) async {
        Database db = await database;
        return await db.update(
            'tareas',
            {'completada': 1},
            where: 'id = ?',
            whereArgs: [id],
        );
    }

}