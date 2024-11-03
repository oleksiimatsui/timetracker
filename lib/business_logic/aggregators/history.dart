
import '../../helpers/date_helpers.dart';
import '../../helpers/store.dart';
import '../entities/activity.dart';
import '../entities/tracking_data.dart';
import 'timetracking_repository.dart';
import '../boundary_crossing_objects/response_model.dart';


class History{
  TimetrackingRepository db;
  History(this.db);
  List<PastTrackingData> _history = [];
  final StreamContainer _historyUpdates = StreamContainer();
  Stream get historyStream => _historyUpdates.stream;

  load(List<Activity> activities) async {
    _history = (await db.getHistory()).map<PastTrackingData>((x) {
      return PastTrackingData(
          x.date,
          x.duration,
          activities
              .where((element) => element.id == x.activityId)
              .firstOrNull);
    }).toList();
  }
  Future<Map<DateTime, List<HistoryItemData>>> getHistory() async {
    Map<DateTime, List<HistoryItemData>> res = <DateTime, List<HistoryItemData>>{};
    for(final hist in _history){
      final histDay = dayStart(hist.startTime);
      if(res[histDay] == null){
        res[histDay] = [];
      }
      res[histDay]!.add(HistoryItemData(hist.activity?.id, hist.duration, hist.startTime));
    }
    return res;
  }
}