import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/job.dart';

class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bookmarks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE bookmarks(
        id TEXT PRIMARY KEY,
        title TEXT,
        company TEXT,
        location TEXT,
        description TEXT
      )
      ''',
    );
  }

  Future<void> addBookmark(Job job) async {
    Database db = await instance.database;
    await db.insert('bookmarks', job.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Job>> getBookmarkedJobs() async {
    Database db = await instance.database;
    var jobs = await db.query('bookmarks');
    List<Job> jobList = jobs.isNotEmpty ? jobs.map((c) => Job.fromJson(c)).toList() : [];
    return jobList;
  }
}
