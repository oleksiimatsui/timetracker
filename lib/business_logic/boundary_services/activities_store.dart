
import '../../helpers/store.dart';
import '../aggregators/activities.dart';
import '../boundary_crossing_objects/response_model.dart';

class ActivitiesStore{
  final Activities _manager;
  List<ActivityData> activities = [];
  ActivitiesStore(this._manager);
  final StreamContainer _activitiesUpdates = StreamContainer();
  Stream get activitiesStream => _activitiesUpdates.stream;

  load() async {
    await _manager.load();
    activities = _manager.getActivitiesData();
    _activitiesUpdates.emit();
  }
  addActivity(String name) async {
    await _manager.addActivity(name);
    await load();
  }

  deleteActivity(int id) async {
    await _manager.deleteActivity(id);
    await load();
  }

  getActivitySavedDuration(int id) {
    return _manager.getActivitySavedDuration(id);
  }
}