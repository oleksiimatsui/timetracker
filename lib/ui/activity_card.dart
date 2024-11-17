import 'package:flutter/material.dart';
import 'package:timetracker/ui/name_editor.dart';
import 'package:timetracker/ui/progress.dart';
import '../business_logic/boundary_services/store_provider.dart';
import '../helpers/display_duration.dart';
import '../business_logic/boundary_crossing_objects/response_model.dart';


/// Activity card widget
///
/// provides buttons for editing and deleting the activity,
/// stopping and resuming the stopwatch,
/// shows the stopwatch's elapsed time
class ActivityWatch extends StatefulWidget {
  ActivityWatch(this.activity);

  /// Activity of the card
  ActivityData activity;

  @override
  State<StatefulWidget> createState() => _ActivityWatchState();
}

class _ActivityWatchState extends State<ActivityWatch> {
  bool editName = false;
  final trackingStore = StoresHub.stopwatchesStore;
  final activitiesStore = StoresHub.activitiesStore;

  toggleStopWatch() {
    if (trackingStore.activityIsRunning(widget.activity.id)) {
      trackingStore.stopActivity();
    } else {
      trackingStore.startActivity(widget.activity.id);
    }
  }

  void deleteActivity() {
    activitiesStore.deleteActivity(widget.activity.id);
  }

  void editMode() {
    setState(() {
      editName = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).cardColor),
      width: 284,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Expanded(
              child: !editName
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.outline),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          color: Theme.of(context).colorScheme.surface),
                      child: Text(
                        widget.activity.name!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ))
                  : TextEditor(widget.activity.name, (value) {
                      StoresHub.activitiesStore
                          .editName(widget.activity.id, value);
                      setState(() {
                        editName = false;
                      });
                    }),
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
                const PopupMenuItem<String>(
                  value: 'editName',
                  child: Text('Edit name'),
                ),
              ],
              onSelected: (String value) {
                switch (value) {
                  case "delete":
                    deleteActivity();
                    break;
                  case "editName":
                    editMode();
                    break;
                }
              },
            ),
          ]),
          StreamBuilder(
              stream: trackingStore.getStopwatchStream(widget.activity.id),
              builder: (context, snapshot) {
                final duration = trackingStore.currentId == widget.activity.id
                    ? trackingStore.runningActivityDuration
                    : activitiesStore
                        .getActivitySavedDuration(widget.activity.id);
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 70,
                              height: 70,
                              decoration: ShapeDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: const CircleBorder(),
                              ),
                              child: IconButton(
                                onPressed: () => toggleStopWatch(),
                                icon: Icon(
                                  trackingStore
                                          .activityIsRunning(widget.activity.id)
                                      ? Icons.pause
                                      : Icons.play_arrow_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  size: 44,
                                ),
                              )),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                              duration != null
                                  ? displayDuration(duration)
                                  : '???',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  )),
                        ],
                      ),
                    ),
                    Progress(duration == null ? 0 : duration.inSeconds,
                        widget.activity.plannedDuration.inSeconds)
                  ],
                );
              })
        ],
      ),
    );
  }
}
