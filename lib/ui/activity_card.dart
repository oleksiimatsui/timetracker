import 'package:flutter/material.dart';
import 'package:timetracker/ui/progress.dart';
import '../business_logic/boundary_services/store_provider.dart';
import '../helpers/display_duration.dart';
import '../business_logic/boundary_crossing_objects/response_model.dart';


class ActivityWatch extends StatelessWidget {
  ActivityData activity;
  ActivityWatch(this.activity, {super.key});
  final trackingStore = StoreProvider.stopwatchesState;
  final activitiesStore = StoreProvider.activitiesState;

  toggleStopWatch() {
    if (trackingStore.activityIsRunning(activity.id)) {
      trackingStore.stopActivity();
    } else {
      trackingStore.startActivity(activity.id);
    }
  }
  void deleteActivity() {
    activitiesStore.deleteActivity(activity.id);
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
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.outline),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Theme.of(context).colorScheme.surface),
              child: Text(
                activity.name!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )),
            PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (String value) {
                if (value == 'delete') {
                  deleteActivity();
                }
              },
            ),
          ]),
          StreamBuilder(stream: trackingStore.getStopwatchStream(activity.id), builder: (context,snapshot){
            final duration = trackingStore.currentId == activity.id ? trackingStore.runningActivityDuration : activitiesStore.getActivitySavedDuration(activity.id);
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
                              trackingStore.activityIsRunning(activity.id)
                                  ? Icons.pause
                                  : Icons.play_arrow_rounded,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 44,
                            ),
                          )),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(duration != null ? displayDuration(duration) : '???',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          )),
                    ],
                  ),
                ),
                Progress(duration == null ? 0 : duration.inSeconds, activity.plannedDuration.inSeconds)
              ],
            );
          })
        ],
      ),
    );
  }


}
