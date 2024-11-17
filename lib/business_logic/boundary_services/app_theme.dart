
import 'package:flutter/material.dart';

import '../../helpers/stream_container.dart';


/// Service for getting and mutating the app theme
class ThemeStore{
  final StreamContainer _stream = StreamContainer();
  Stream get stream => _stream.stream;
  late ThemeData _themeData;
  late Color _color;
  ThemeStore(){
    _color = const Color.fromRGBO(255, 213, 0, 1.0);
    _setTheme();
  }
  _setTheme(){
    _themeData = ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: _color,
            brightness: Brightness.light),
        useMaterial3: true,
        textTheme: const TextTheme());
  }
  setTheme(color){
    _color = color;
    _setTheme();
    _stream.emit();
  }
  get getTheme => _themeData;
}