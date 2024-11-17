


/// returns a string that represents [duration] in the format `HH:mm:ss.s`
/// Example:
/// ```dart
/// final duration = Duration(hours: 2, minutes: 5, seconds: 30, milliseconds: 123);
/// final formatted = displayDuration(duration);
/// print(formatted); // Output: "02:05:30.1"
/// ```
displayDuration(Duration duration) {
  return '${duration.inHours.remainder(60).toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}.${(duration.inMilliseconds % 1000 ~/ 100).toString()}';
}