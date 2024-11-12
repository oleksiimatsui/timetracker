import 'package:timetracker/business_logic/boundary_crossing_objects/database_model.dart';
import '../../helpers/date_helpers.dart';
import '../../helpers/store.dart';
import '../entities/activity.dart';
import '../entities/tracking_data.dart';
import '../boundary_crossing_objects/response_model.dart';


class History{
  HistoryDSInterface db;
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
    }).where((x)=>x.activity != null).toList();
    _historyUpdates.emit();
  }
  Map<DateTime, List<HistoryItemData>> getHistory() {
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