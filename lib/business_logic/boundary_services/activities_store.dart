import '../../helpers/stream_container.dart';
import '../aggregators/activities.dart';
import '../boundary_crossing_objects/response_model.dart';


/// Service for getting and mutating the activities
class ActivitiesStore{

  ActivitiesStore(this._manager){
    _manager.activitiesStream.listen((event) {
      activities = _manager.getActivities()
          .map((x) => ActivityData(x.id ?? 0, x.name, x.plannedDuration))
          .toList();
      _activitiesUpdates.emit();
    });
  }

  /// internal activities state that contains the list of all activities currently stored
  final Activities _manager;

  /// activities data for external usage
  List<ActivityData> activities = [];

  /// stream of activities' updates
  final StreamContainer _activitiesUpdates = StreamContainer();
  Stream get activitiesStream => _activitiesUpdates.stream;
  dispose(){
    _activitiesUpdates.dispose();
  }

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