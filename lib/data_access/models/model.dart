import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

part 'model.g.dart';

@freezed
class ActivityModel with _$ActivityModel {
  factory ActivityModel(
      {required int id,
      required String name,
      String? color,
      required int plannedSeconds}) = _ActivityModel;

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);
}

@freezed
class ActiveTDModel with _$ActiveTDModel {
  factory ActiveTDModel(
      {required int id,
      required bool isRunning,
      required DateTime lastChangeTime,
      required Duration duration}) = _ActiveTDModel;

  factory ActiveTDModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveTDModelFromJson(json);
}

@freezed
class PastTDModel with _$PastTDModel {
  factory PastTDModel(
      {required DateTime startTime,
      required DateTime endTime,
      required int activityId}) = _PastTDModel;

  factory PastTDModel.fromJson(Map<String, dynamic> json) =>
      _$PastTDModelFromJson(json);
}
