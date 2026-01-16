import '../../helpers/stream_container.dart';
import '../aggregators/history.dart';
import '../boundary_crossing_objects/response_model.dart';
import '../entities/activity.dart';

/// Service for getting and mutating the history
class HistoryStore {
  Map<DateTime, List<HistoryItemData>> history =
      <DateTime, List<HistoryItemData>>{};
  Map<DateTime, List<HistoryItemData>> _history =
      <DateTime, List<HistoryItemData>>{};
  final History _manager;
  DateTime month = DateTime.now();

  final StreamContainer _historyUpdates = StreamContainer();
  Stream get historyStream => _historyUpdates.stream;
  dispose(){
    _historyUpdates.dispose();
  }

  HistoryStore(this._manager) {
    _manager.historyStream.listen((event) {
      _history = _manager.getHistory();
      filterHistory();
    });
  }

  load(List<Activity> activities) {
    _manager.load(activities);
  }

  setMonth(DateTime month) {
    this.month = month;
    filterHistory();
  }

  filterHistory() {
    final m = DateTime(month.year, month.month, 0);
    history = Map.fromEntries(_history.entries.where((x) {
      return DateTime(x.key.year, x.key.month, 0) == m;
    }));
    _historyUpdates.emit();
  }
}
