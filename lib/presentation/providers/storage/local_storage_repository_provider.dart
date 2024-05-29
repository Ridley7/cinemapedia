
import 'package:cinemapedia/infrastructure/datasources/isar_datasource_implementation.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImplementation(datasource: IsarDatasourceImplementation());
});