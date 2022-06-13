import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../entities/project.dart';
import '../../entities/project_task.dart';
import 'database.dart';

class DatabaseImpl implements Database {
  Isar? _databaseInstance;

  @override
  Future<Isar> openConnection() async {
    Directory dir = Directory('');

    if (!kIsWeb) {
      dir = await getApplicationSupportDirectory();
    }

    _databaseInstance ??= await Isar.open(
      schemas: [
        ProjectTaskSchema,
        ProjectSchema,
      ],
      directory: dir.path,
      inspector: true,
    );

    return _databaseInstance!;
  }
}
