import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timetracker/ui/app.dart';
import 'business_logic/boundary_services/store_provider.dart';
import 'data_access/activities_database.dart';
import 'data_access/history_database.dart';
import 'data_access/stopwatches_database.dart';

_getPath() async {
  final directory = await getApplicationDocumentsDirectory();
  String p = directory.path;
  return p;
}

void main() async {
  final path = await _getPath();
  StoreProvider.createStores(StopwatchesDatabase(path), HistoryDatabase(path), ActivitiesDatabase(path));
  StoreProvider.load();
  runApp(const MyApp());
}
