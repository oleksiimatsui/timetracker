import '../business_logic/boundary_crossing_objects/database_model.dart';
import './models/model.dart';
import 'json_saver.dart';

class HistoryDatasource extends HistoryDSInterface {
  JsonSaver saver;

  HistoryDatasource(String path) : saver = JsonSaver('$path/history');

  @override
  Future<List<HistoryItemStorageModel>> getHistory() async {
    return (await _getHistory()).map<HistoryItemStorageModel>((x) {
      final model = PastTDModel.fromJson(x);
      return HistoryItemStorageModel(
          model.startTime, model.endTime.difference(model.startTime), model.activityId);
    }).toList();
  }

  @override
  addHistory(List<HistoryItemStorageModel> hystory) async {
    final histories = await _getHistory();
    await _saveHistory([
      ...histories,
      ...hystory.map<Map<String, dynamic>>((model)=>
      PastTDModel(
        startTime: model.date,
        endTime: model.date.add(model.duration),
        activityId: model.activityId,
      ).toJson()).toList()
    ]);
  }

  clear() async {
    await saver.writeData({'history': []});
  }

  Future<List<dynamic>> _getHistory() async {
    return (await saver.readData())?['history'] ?? [];
  }

  _saveHistory(activities) async {
    await saver.writeData({'history': activities});
  }
}
