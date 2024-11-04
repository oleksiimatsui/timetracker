import '../business_logic/boundary_crossing_objects/database_model.dart';
import './models/model.dart';
import 'json_saver.dart';

class HistoryDatabase extends HistoryDBInterface {
  JsonSaver saver;

  HistoryDatabase(String path) : saver = JsonSaver('$path/history');

  @override
  Future<List<HistoryItemDBModel>> getHistory() async {
    return (await _getHistory()).map<HistoryItemDBModel>((x) {
      final model = PastTDModel.fromJson(x);
      return HistoryItemDBModel(
          model.startTime, model.endTime.difference(model.startTime), model.activityId);
    }).toList();
  }

  @override
  addHistory(List<HistoryItemDBModel> hystory) async {
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
