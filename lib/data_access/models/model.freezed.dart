// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return _ActivityModel.fromJson(json);
}

/// @nodoc
mixin _$ActivityModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int get plannedSeconds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityModelCopyWith<ActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityModelCopyWith<$Res> {
  factory $ActivityModelCopyWith(
          ActivityModel value, $Res Function(ActivityModel) then) =
      _$ActivityModelCopyWithImpl<$Res, ActivityModel>;
  @useResult
  $Res call({int id, String name, String? color, int plannedSeconds});
}

/// @nodoc
class _$ActivityModelCopyWithImpl<$Res, $Val extends ActivityModel>
    implements $ActivityModelCopyWith<$Res> {
  _$ActivityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
    Object? plannedSeconds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      plannedSeconds: null == plannedSeconds
          ? _value.plannedSeconds
          : plannedSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityModelImplCopyWith<$Res>
    implements $ActivityModelCopyWith<$Res> {
  factory _$$ActivityModelImplCopyWith(
          _$ActivityModelImpl value, $Res Function(_$ActivityModelImpl) then) =
      __$$ActivityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? color, int plannedSeconds});
}

/// @nodoc
class __$$ActivityModelImplCopyWithImpl<$Res>
    extends _$ActivityModelCopyWithImpl<$Res, _$ActivityModelImpl>
    implements _$$ActivityModelImplCopyWith<$Res> {
  __$$ActivityModelImplCopyWithImpl(
      _$ActivityModelImpl _value, $Res Function(_$ActivityModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
    Object? plannedSeconds = null,
  }) {
    return _then(_$ActivityModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      plannedSeconds: null == plannedSeconds
          ? _value.plannedSeconds
          : plannedSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityModelImpl implements _ActivityModel {
  _$ActivityModelImpl(
      {required this.id,
      required this.name,
      this.color,
      required this.plannedSeconds});

  factory _$ActivityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? color;
  @override
  final int plannedSeconds;

  @override
  String toString() {
    return 'ActivityModel(id: $id, name: $name, color: $color, plannedSeconds: $plannedSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.plannedSeconds, plannedSeconds) ||
                other.plannedSeconds == plannedSeconds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color, plannedSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityModelImplCopyWith<_$ActivityModelImpl> get copyWith =>
      __$$ActivityModelImplCopyWithImpl<_$ActivityModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityModelImplToJson(
      this,
    );
  }
}

abstract class _ActivityModel implements ActivityModel {
  factory _ActivityModel(
      {required final int id,
      required final String name,
      final String? color,
      required final int plannedSeconds}) = _$ActivityModelImpl;

  factory _ActivityModel.fromJson(Map<String, dynamic> json) =
      _$ActivityModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get color;
  @override
  int get plannedSeconds;
  @override
  @JsonKey(ignore: true)
  _$$ActivityModelImplCopyWith<_$ActivityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActiveTDModel _$ActiveTDModelFromJson(Map<String, dynamic> json) {
  return _ActiveTDModel.fromJson(json);
}

/// @nodoc
mixin _$ActiveTDModel {
  int get id => throw _privateConstructorUsedError;
  bool get isRunning => throw _privateConstructorUsedError;
  DateTime get lastChangeTime => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActiveTDModelCopyWith<ActiveTDModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveTDModelCopyWith<$Res> {
  factory $ActiveTDModelCopyWith(
          ActiveTDModel value, $Res Function(ActiveTDModel) then) =
      _$ActiveTDModelCopyWithImpl<$Res, ActiveTDModel>;
  @useResult
  $Res call(
      {int id, bool isRunning, DateTime lastChangeTime, Duration duration});
}

/// @nodoc
class _$ActiveTDModelCopyWithImpl<$Res, $Val extends ActiveTDModel>
    implements $ActiveTDModelCopyWith<$Res> {
  _$ActiveTDModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isRunning = null,
    Object? lastChangeTime = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isRunning: null == isRunning
          ? _value.isRunning
          : isRunning // ignore: cast_nullable_to_non_nullable
              as bool,
      lastChangeTime: null == lastChangeTime
          ? _value.lastChangeTime
          : lastChangeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActiveTDModelImplCopyWith<$Res>
    implements $ActiveTDModelCopyWith<$Res> {
  factory _$$ActiveTDModelImplCopyWith(
          _$ActiveTDModelImpl value, $Res Function(_$ActiveTDModelImpl) then) =
      __$$ActiveTDModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, bool isRunning, DateTime lastChangeTime, Duration duration});
}

/// @nodoc
class __$$ActiveTDModelImplCopyWithImpl<$Res>
    extends _$ActiveTDModelCopyWithImpl<$Res, _$ActiveTDModelImpl>
    implements _$$ActiveTDModelImplCopyWith<$Res> {
  __$$ActiveTDModelImplCopyWithImpl(
      _$ActiveTDModelImpl _value, $Res Function(_$ActiveTDModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isRunning = null,
    Object? lastChangeTime = null,
    Object? duration = null,
  }) {
    return _then(_$ActiveTDModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isRunning: null == isRunning
          ? _value.isRunning
          : isRunning // ignore: cast_nullable_to_non_nullable
              as bool,
      lastChangeTime: null == lastChangeTime
          ? _value.lastChangeTime
          : lastChangeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveTDModelImpl implements _ActiveTDModel {
  _$ActiveTDModelImpl(
      {required this.id,
      required this.isRunning,
      required this.lastChangeTime,
      required this.duration});

  factory _$ActiveTDModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveTDModelImplFromJson(json);

  @override
  final int id;
  @override
  final bool isRunning;
  @override
  final DateTime lastChangeTime;
  @override
  final Duration duration;

  @override
  String toString() {
    return 'ActiveTDModel(id: $id, isRunning: $isRunning, lastChangeTime: $lastChangeTime, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveTDModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isRunning, isRunning) ||
                other.isRunning == isRunning) &&
            (identical(other.lastChangeTime, lastChangeTime) ||
                other.lastChangeTime == lastChangeTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, isRunning, lastChangeTime, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveTDModelImplCopyWith<_$ActiveTDModelImpl> get copyWith =>
      __$$ActiveTDModelImplCopyWithImpl<_$ActiveTDModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveTDModelImplToJson(
      this,
    );
  }
}

abstract class _ActiveTDModel implements ActiveTDModel {
  factory _ActiveTDModel(
      {required final int id,
      required final bool isRunning,
      required final DateTime lastChangeTime,
      required final Duration duration}) = _$ActiveTDModelImpl;

  factory _ActiveTDModel.fromJson(Map<String, dynamic> json) =
      _$ActiveTDModelImpl.fromJson;

  @override
  int get id;
  @override
  bool get isRunning;
  @override
  DateTime get lastChangeTime;
  @override
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$$ActiveTDModelImplCopyWith<_$ActiveTDModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PastTDModel _$PastTDModelFromJson(Map<String, dynamic> json) {
  return _PastTDModel.fromJson(json);
}

/// @nodoc
mixin _$PastTDModel {
  int get id => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  int get activityId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PastTDModelCopyWith<PastTDModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PastTDModelCopyWith<$Res> {
  factory $PastTDModelCopyWith(
          PastTDModel value, $Res Function(PastTDModel) then) =
      _$PastTDModelCopyWithImpl<$Res, PastTDModel>;
  @useResult
  $Res call({int id, DateTime startTime, DateTime endTime, int activityId});
}

/// @nodoc
class _$PastTDModelCopyWithImpl<$Res, $Val extends PastTDModel>
    implements $PastTDModelCopyWith<$Res> {
  _$PastTDModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? activityId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PastTDModelImplCopyWith<$Res>
    implements $PastTDModelCopyWith<$Res> {
  factory _$$PastTDModelImplCopyWith(
          _$PastTDModelImpl value, $Res Function(_$PastTDModelImpl) then) =
      __$$PastTDModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, DateTime startTime, DateTime endTime, int activityId});
}

/// @nodoc
class __$$PastTDModelImplCopyWithImpl<$Res>
    extends _$PastTDModelCopyWithImpl<$Res, _$PastTDModelImpl>
    implements _$$PastTDModelImplCopyWith<$Res> {
  __$$PastTDModelImplCopyWithImpl(
      _$PastTDModelImpl _value, $Res Function(_$PastTDModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? activityId = null,
  }) {
    return _then(_$PastTDModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PastTDModelImpl implements _PastTDModel {
  _$PastTDModelImpl(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.activityId});

  factory _$PastTDModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PastTDModelImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final int activityId;

  @override
  String toString() {
    return 'PastTDModel(id: $id, startTime: $startTime, endTime: $endTime, activityId: $activityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PastTDModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, startTime, endTime, activityId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PastTDModelImplCopyWith<_$PastTDModelImpl> get copyWith =>
      __$$PastTDModelImplCopyWithImpl<_$PastTDModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PastTDModelImplToJson(
      this,
    );
  }
}

abstract class _PastTDModel implements PastTDModel {
  factory _PastTDModel(
      {required final int id,
      required final DateTime startTime,
      required final DateTime endTime,
      required final int activityId}) = _$PastTDModelImpl;

  factory _PastTDModel.fromJson(Map<String, dynamic> json) =
      _$PastTDModelImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  int get activityId;
  @override
  @JsonKey(ignore: true)
  _$$PastTDModelImplCopyWith<_$PastTDModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
