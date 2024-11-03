import '../business_logic/boundary_crossing_objects/database_model.dart';
import './models/model.dart';
import 'json_saver.dart';

class HistoryDatabase extends HistoryDBInterface {
  JsonSaver saver;

  HistoryDatabase(String path) : saver = JsonSaver('$path/history');

  @override
  Future<List<HistoryDBModel>> getHistory() async {
    return (await _getHistory()).map<HistoryDBModel>((x) {
      final model = PastTDModel.fromJson(x);
      return HistoryDBModel(
          model.startTime, model.endTime.difference(model.startTime), model.activityId);
    }).toList();
  }

  @override
  addHistory(HistoryDBModel model) async {
    final histories = await _getHistory();
    await _saveHistory([
      ...histories,
      PastTDModel(
        id: await _getId(),
        startTime: model.date,
        endTime: model.date.add(model.duration),
        activityId: model.activityId,
      ).toJson()
    ]);
  }

  clear() async {
    await saver.writeData({'history': []});
  }

  Future<int> _getId() async {
    List<dynamic> histories = await _getHistory();
    if (histories.isEmpty) return 1;
    int maxId = histories
        .map<int>((activity) => activity['id']) // Map to IDs
        .reduce((a, b) => a > b ? a : b); // Get the maximum ID
    return maxId + 1;
  }

  Future<List<dynamic>> _getHistory() async {
    return (await saver.readData())?['history'] ?? [];
  }

  _saveHistory(activities) async {
    await saver.writeData({'history': activities});
  }
}
