
import '../business_logic/boundary_crossing_objects/database_model.dart';
import './models/model.dart';
import 'json_saver.dart';

class ActivitiesDatabase extends ActivityDBInterface {
  JsonSaver saver;

  ActivitiesDatabase(String path)
      : saver = JsonSaver('$path/activities');

  @override
  Future<List<ActivityDBModel>> getActivities() async {
    List<dynamic> activitiesData = await _getActivities();
    List<ActivityDBModel> activities = activitiesData.map<ActivityDBModel>((dynamic x) {
      final ac = ActivityModel.fromJson(x);
      var activity = ActivityDBModel(
        ac.id,
        ac.name,
        Duration(seconds: ac.plannedSeconds),
      );
      return activity;
    }).toList();
    return activities;
  }

  @override
  addActivity(ActivityDBModel model) async {
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
    await saver.writeData({
      'activities':
          activities.where((activity) => activity['id'] != id).toList() ?? []
    });
  }

  @override
  updateActivity(ActivityDBModel model) async {
    final activities = await _getActivities();
    var newActivity = ActivityModel(
        id: model.id!,
        name: model.name!,
        plannedSeconds: model.plannedDuration!.inSeconds);
    var newActivities = activities;
    newActivities[
            newActivities.indexWhere((element) => element['id'] == model.id)] =
        newActivity.toJson();
    await saver.writeData({'activities': newActivities});
  }

  clear() async {
    await saver.writeData({'activities': []});
  }

  Future<int> _getId() async {
    List<dynamic> activities = await _getActivities();
    if (activities.isEmpty) return 1;
    int maxId = activities
        .map<int>((activity) => activity['id']) // Map to IDs
        .reduce((a, b) => a > b ? a : b); // Get the maximum ID
    return maxId + 1;
  }

  Future<List<dynamic>> _getActivities() async {
    return (await saver.readData())?['activities'] ?? [];
  }

  _saveActivities(activities) async {
    await saver.writeData({'activities': activities});
  }
}
