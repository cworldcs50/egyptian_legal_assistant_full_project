import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'i_database.dart';
import '../../features/home/chatbot/models/chat_message_model.dart';
import '../../features/home/chatbot/models/citation_model.dart';

class ChatHistoryDatabase implements IDatabase {
  static final ChatHistoryDatabase instance = ChatHistoryDatabase._init();
  static Database? _database;

  ChatHistoryDatabase._init();

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('chat_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    // const boolType = 'INTEGER NOT NULL';
    // const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE sessions (
  id $idType,
  title $textType,
  last_message $textType,
  updated_at $textType
)
''');

    await db.execute('''
CREATE TABLE messages (
  id $idType,
  session_id $textType,
  role $textType,
  content $textType,
  timestamp $textType,
  citations $textType
)
''');
  }

  // Session operations
  Future<void> upsertSession({
    required String id,
    required String title,
    required String lastMessage,
    required DateTime updatedAt,
  }) async {
    final db = await instance.database;
    await db.insert(
      'sessions',
      {
        'id': id,
        'title': title,
        'last_message': lastMessage,
        'updated_at': updatedAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllSessions() async {
    final db = await instance.database;
    return await db.query('sessions', orderBy: 'updated_at DESC');
  }

  // Message operations
  Future<void> insertMessage(String sessionId, ChatMessage message) async {
    final db = await instance.database;
    final citationsJson = message.citations != null
        ? jsonEncode(message.citations!.map((c) => c.toJson()).toList())
        : '';
        
    await db.insert(
      'messages',
      {
        'id': message.id,
        'session_id': sessionId,
        'role': message.role.name,
        'content': message.message,
        'timestamp': message.timestamp.toIso8601String(),
        'citations': citationsJson,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChatMessage>> getMessagesForSession(String sessionId) async {
    final db = await instance.database;
    final result = await db.query(
      'messages',
      where: 'session_id = ?',
      whereArgs: [sessionId],
      orderBy: 'timestamp ASC',
    );

    return result.map((json) {
      List<Citation>? citationsList;
      final citationsStr = json['citations'] as String?;
      
      if (citationsStr != null && citationsStr.isNotEmpty) {
        try {
          final decoded = jsonDecode(citationsStr) as List;
          citationsList = decoded.map((e) => Citation.fromJson(e as Map<String, dynamic>)).toList();
        } catch (e) {
          // Fallback if parsing fails
          citationsList = null;
        }
      }

      return ChatMessage(
        id: json['id'] as String,
        message: json['content'] as String,
        role: MessageRole.values.firstWhere((e) => e.name == json['role']),
        timestamp: DateTime.parse(json['timestamp'] as String),
        citations: citationsList,
      );
    }).toList();
  }

  Future<void> deleteSession(String sessionId) async {
    final db = await instance.database;
    await db.delete('sessions', where: 'id = ?', whereArgs: [sessionId]);
    await db.delete('messages', where: 'session_id = ?', whereArgs: [sessionId]);
  }

  Future<void> clearAllSessions() async {
    final db = await instance.database;
    await db.delete('sessions');
    await db.delete('messages');
  }
}
