
import '../business_logic/boundary_crossing_objects/database_model.dart';
import './models/model.dart';
import 'json_saver.dart';

class StopwatchesDatabase extends StopwatchDBInterface {
  JsonSaver saver;

  StopwatchesDatabase(String path)
      : saver = JsonSaver('$path/stopwatches');

  @override
  Future<List<StopwatchDBModel>> getStopwatches() async {
    List<dynamic> stopwatchesData = await _getStopwatches();
    List<StopwatchDBModel> res = stopwatchesData.map<StopwatchDBModel>((dynamic x) {
        final stopwatch = ActiveTDModel.fromJson(x);
        return StopwatchDBModel(
          stopwatch.id,
            stopwatch.duration,
            stopwatch.isRunning,
            stopwatch.lastChangeTime);
    }).toList();
    return res;
  }

  @override
  updateStopwatch(StopwatchDBModel model) async {
    List<dynamic> stopwatches = await _getStopwatches();
    var newWatch = ActiveTDModel(
        id: model.id!,
        isRunning: model.isRunning,
        lastChangeTime: model.lastChangeTime!,
        duration: model.duration);
    final index =
        stopwatches.indexWhere((element) => element['id'] == model.id);
    if (index == -1) {
      stopwatches.add(newWatch.toJson());
    } else {
      stopwatches[index] = newWatch.toJson();
    }
    await _saveStopwatches(stopwatches);
  }
  clear() async {
    await saver.writeData({'activities': []});
  }

  Future<List<dynamic>> _getStopwatches() async {
    return (await saver.readData())?['activeData'] ?? [];
  }

  _saveStopwatches(stopwatches) async {
    await saver.writeData({'activeData': stopwatches});
  }
}
