import 'package:flutter/material.dart';
import 'package:timetracker/ui/add_activity.dart';
import 'package:timetracker/ui/activity_card.dart';
import '../business_logic/boundary_services/store_provider.dart';


/// Displays activities in a scrollable column
class TimetrackingWindow extends StatelessWidget {
  TimetrackingWindow({super.key});

  addActivity() {}
  final store = StoresHub.activitiesStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.activitiesStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final activities = store.activities;
        return SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NewActivityWidget(),
              ...List.generate(
                activities.length,
                (index) => ActivityWatch(activities[index]),
              ),
            ],
        ));
      },
    );
  }
}
