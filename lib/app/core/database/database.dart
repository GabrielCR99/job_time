import 'package:isar/isar.dart';

abstract interface class Database {
  Future<Isar> openConnection();
}
