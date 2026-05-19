import 'package:sqflite/sqflite.dart';

abstract class IDatabase {
  Future<Database> get database;
  
}
