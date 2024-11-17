import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timetracker/ui/app.dart';
import 'business_logic/boundary_services/store_provider.dart';
import 'data_access/activities_datasource.dart';
import 'data_access/history_datasource.dart';
import 'data_access/stopwatches_datasource.dart';


///returns path to the storage directory for the data sources
_getPath() async {
  final directory = await getApplicationDocumentsDirectory();
  String p = directory.path;
  return p;
}

/// assembles the dependencies and runs the app
void main() async {
  final path = await _getPath();
  StoresHub.createStores(StopwatchesDatasource(path), HistoryDatasource(path), ActivitiesDatasource(path));
  StoresHub.load();
  runApp(const MyApp());
}
