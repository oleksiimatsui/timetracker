import 'dart:async';



/// helper class for emitting the updates stream
///
/// contains broadcast stream controller with no containing class
/// Example of usage:
/// ```dart
/// final StreamContainer _myUpdates = StreamContainer(sync: true);
/// Stream get activitiesStream => _myUpdates.stream;
/// _myUpdates.emit()
/// ```
class StreamContainer{
  final StreamController _controller;
  Stream get stream => _controller.stream;

  /// Creates a new `StreamContainer`.
  ///
  /// If [sync] is true, the emitted updates will be processed immediately
  StreamContainer({bool? sync}) :  _controller = StreamController.broadcast(sync: sync == true ? true : false);

  /// Emits an update to all subscribers of the stream.
  void emit() {
    _controller.add(null);
  }
}

/// a map of [StreamContainer] with integer keys
///
/// before emitting controllers or getting the streams, you should call [init] method
class StreamMap{
  final Map<int, StreamContainer> _map = Map<int,StreamContainer>();

  /// Emits an update for the stream associated with the given [id].
  ///
  /// Throws a `StateError` if the stream controller for the given key is closed.
  /// Throws a `NoSuchMethodError` if the key [id] does not exist in the map.
  void emit(int id) {
    _map[id]!.emit();
  }
  /// Returns the stream associated with the given [id].
  ///
  /// Throws a `NoSuchMethodError` if the key [id] does not exist in the map.
  Stream get(int id){
    return _map[id]!.stream;
  }

  /// Initializes the map with the provided [keys].
  ///
  /// For each key in [keys], a new `StreamContainer` is created and associated
  /// with the key in the map. This method should be called before attempting to
  /// use [emit] or [get].
  /// Keys that are already present in the map will be overwritten with new StreamContainer instances.
  void init(List<int> keys){
    for(int key in keys){
      _map[key] = StreamContainer();
    }
  }
}