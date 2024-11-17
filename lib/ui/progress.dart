import 'dart:math';

import 'package:flutter/material.dart';

/// displays a progress bar
///
/// the progress bar coefficient is calculated as [_current]/[_max]
class Progress extends StatelessWidget {
  const Progress(this._current, this._max, {super.key});
  final int _current;
  final int _max;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10,

        color: Theme.of(context).colorScheme.surfaceVariant,
        alignment: Alignment.topLeft,
        child:
          FractionallySizedBox(
            widthFactor: min<double>(_current / _max, 1),
            heightFactor: 1,
            child: Container(
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        );
  }
}
