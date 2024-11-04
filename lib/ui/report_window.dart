import 'package:flutter/material.dart';
import 'package:timetracker/helpers/display_duration.dart';
import '../business_logic/boundary_crossing_objects/response_model.dart';
import '../business_logic/boundary_services/store_provider.dart';

class ReportWindow extends StatelessWidget {
  ReportWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StoreProvider.activitiesState.activitiesStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Map<DateTime, List<HistoryItemData>> history =
            StoreProvider.historyState.history;
        final activities = StoreProvider.activitiesState.activities;
        final length = activities.length;
        Map<int, Duration> totalSums = <int, Duration>{};

        for (final entry in history.entries) {
          List<HistoryItemData> items = entry.value;
          for (HistoryItemData item in items) {
            int activityId = item.activityId ?? 0;
            Duration duration = item.duration;
            totalSums[activityId] = totalSums[activityId] != null ? totalSums[activityId]! + duration :
                const Duration(seconds: 0) + (duration);
          }
        }
        final totals = totalSums.values.toList();
        return SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(10),
          child: DataTable(columns: [
            DataColumn(label: Text("Date")),
            ...List.generate(
                length,
                (index) =>
                    DataColumn(label: Text(activities[index]?.name ?? '')))
          ], rows: [
            ...history.entries.map<DataRow>((hist) {
              return DataRow(cells: [
                DataCell(Text(hist.key.day.toString())),
                ...List.generate(
                    length,
                    (index) => DataCell(Text(index < hist.value.length
                        ? (displayDuration(hist.value[index].duration))
                        : "")))
              ]);
            }),
            DataRow(cells: [
              DataCell(Text("Total")),
              ...List.generate(
                  length,
                  (index) => DataCell(Text(index < totals.length
                      ? (displayDuration(totals[index]))
                      : "")))
            ])
          ]),
        ));
      },
    );
  }
}
