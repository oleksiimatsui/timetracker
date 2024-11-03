import 'dart:math';

import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  Progress(this._current, this._max, {super.key}) {}
  int _current;
  int _max;

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
