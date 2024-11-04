
import '../../helpers/store.dart';
import '../aggregators/activities.dart';
import '../boundary_crossing_objects/response_model.dart';

class ActivitiesStore{
  final Activities _manager;
  List<ActivityData> activities = [];
  ActivitiesStore(this._manager){
    _manager.activitiesStream.listen((event) {
      activities = _manager.getActivities()
          .map((x) => ActivityData(x.id ?? 0, x.name, x.plannedDuration))
          .toList();
      _activitiesUpdates.emit();
    });
  }
  final StreamContainer _activitiesUpdates = StreamContainer();
  Stream get activitiesStream => _activitiesUpdates.stream;
  addActivity(String name) async {
    await _manager.addActivity(name);
  }

  deleteActivity(int id) async {
    await _manager.deleteActivity(id);
  }

  getActivitySavedDuration(int id) {
    return _manager.getActivitySavedDuration(id);
  }

  void editName(int id, String value) async{
    await _manager.editActivityName(id, value);
  }
}