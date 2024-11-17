
import '../business_logic/boundary_crossing_objects/database_model.dart';
import './models/model.dart';
import 'json_saver.dart';

/// stores the activities in a file as a json object
class ActivitiesDatasource extends ActivityDSInterface {
  JsonSaver saver;

  ActivitiesDatasource(String path)
      : saver = JsonSaver('$path/activities');

  @override
  Future<List<ActivityStorageModel>> getActivities() async {
    List<dynamic> activitiesData = await _getActivities();
    List<ActivityStorageModel> activities = activitiesData.map<ActivityStorageModel>((dynamic x) {
      final ac = ActivityModel.fromJson(x);
      var activity = ActivityStorageModel(
        ac.id,
        ac.name,
        Duration(seconds: ac.plannedSeconds),
      );
      return activity;
    }).toList();
    return activities;
  }

  @override
  addActivity(ActivityStorageModel model) async {
    final activities = await _getActivities();
    await _saveActivities([
      ...activities,
      ActivityModel(
              id: await _getId(),
              name: model.name ?? '',
              color: null,
              plannedSeconds: model.plannedDuration!.inSeconds ?? 0)
          .toJson()
    ]);
  }

  @override
  deleteActivity(int id) async {
    final activities = await _getActivities();
    await _saveActivities(activities.where((activity) => activity['id'] != id).toList() ?? []);
  }

  @override
  updateActivity(ActivityStorageModel model) async {
    final activities = await _getActivities();
    var newActivity = ActivityModel(
        id: model.id!,
        name: model.name!,
        plannedSeconds: model.plannedDuration!.inSeconds);
    var newActivities = activities;
    newActivities[
            newActivities.indexWhere((element) => element['id'] == model.id)] =
        newActivity.toJson();
    await _saveActivities(newActivities);
  }

  clear() async {
    await _saveActivities([]);
  }

  List<dynamic> _activities = [];
  int _id = 0;

  Future<int> _getId() async {
    var data = (await saver.readData());
    _id = data?['id'] ?? 0;
    await saver.writeData({'activities': _activities, 'id': _id+1});
    data = (await saver.readData());
    return _id++;
  }

  Future<List<dynamic>> _getActivities() async {
    _activities = (await saver.readData())?['activities'] ?? [];
    return _activities;
  }

  _saveActivities(activities) async {
    await saver.writeData({'activities': activities, "id": _id});
  }
}
