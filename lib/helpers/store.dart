
import 'dart:async';

// class Store<T>{
//   final StreamController<T> _controller = StreamController.broadcast();
//   final T _state;
//   T get state => _state;
//   Stream<T> get stream => _controller.stream;
//   Store(T state): _state = state;
//   void emit(T state) {
//     _controller.add(state); // Notify listeners of the new state
//   }
// }


class StreamContainer{
  final StreamController _controller;
  Stream get stream => _controller.stream;
  StreamContainer({bool? sync}) :  _controller = StreamController.broadcast(sync: sync == true ? true : false);
  void emit() {
    _controller.add(null);
  }
}

class StreamMap{
  Map<int, StreamContainer> _map = Map<int,StreamContainer>();
  void emit(int id) {
    _map[id]!.emit();
  }
  Stream get(int id){
    return _map[id]!.stream;
  }
  void init(List<int> keys){
    for(int key in keys){
      _map[key] = StreamContainer();
    }
  }
}