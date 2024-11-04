import '../aggregators/history.dart';
import '../boundary_crossing_objects/response_model.dart';
import '../entities/activity.dart';

class HistoryStore{
  Map<DateTime, List<HistoryItemData>> history = <DateTime, List<HistoryItemData>>{};
  final History _manager;
  HistoryStore(this._manager){
    _manager.historyStream.listen((event) {
      history = _manager.getHistory();
    });
  }
  load(List<Activity> activities){
    history = _manager.load(activities);
  }
}