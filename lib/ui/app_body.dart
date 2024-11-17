import 'package:flutter/material.dart';
import 'package:timetracker/ui/report_window.dart';
import 'package:timetracker/ui/timetracking_window.dart';

/// builds interface with timetracking and history windows and left sidebar
class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<StatefulWidget> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(

              border: Border.symmetric( vertical: BorderSide(color: Theme.of(context).colorScheme.outline), ),
              color: Theme.of(context).colorScheme.secondaryContainer),
          child: Column(
            children: [
              IconButton(
                  onPressed: () => setState(() {
                        currentPage = 0;
                      }),
                  isSelected: currentPage == 0,
                  icon: Icon(Icons.watch_later_outlined,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      weight: currentPage == 0 ? 900 : null)),
              IconButton(
                  onPressed: () => setState(() {
                        currentPage = 1;
                      }),
                  isSelected: currentPage == 1,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  icon: Icon(Icons.history_toggle_off,
                      weight: currentPage == 1 ? 900 : null))
            ],
          ),
        ),

        Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
                color: Theme.of(context).colorScheme.surfaceVariant,
                child:
                    currentPage == 0 ? TimetrackingWindow() : ReportWindow()))
      ],
    );
  }
}
