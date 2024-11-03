import 'package:flutter/material.dart';
import 'package:timetracker/ui/add_activity.dart';
import 'package:timetracker/ui/activity_card.dart';
import '../business_logic/boundary_services/store_provider.dart';

class TimetrackingWindow extends StatelessWidget {
  addActivity() {}
  final store = StoreProvider.activitiesState;

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
