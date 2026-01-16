import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/helpers/display_duration.dart';
import '../business_logic/boundary_crossing_objects/response_model.dart';
import '../business_logic/boundary_services/store_provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:multi_stream_builder/multi_stream_builder.dart';

class ReportWindow extends StatelessWidget {
  ReportWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiStreamBuilder(
      streams: [StoresHub.activitiesStore.activitiesStream, StoresHub.historyStore.historyStream],
      builder: (BuildContext context, dataList) {
        Map<DateTime, List<HistoryItemData>> history =
            StoresHub.historyStore.history;
        final activities = StoresHub.activitiesStore.activities;
        final length = activities.length;
        Map<int, Duration> totalSums = <int, Duration>{};

        for (final entry in history.entries) {
          List<HistoryItemData> items = entry.value;
          for (HistoryItemData item in items) {
            int activityId = item.activityId ?? 0;
            Duration duration = item.duration;
            totalSums[activityId] = totalSums[activityId] != null
                ? totalSums[activityId]! + duration
                : const Duration(seconds: 0) + (duration);
          }
        }

        return SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text( DateFormat.MMMM().format(StoresHub.historyStore.month)),
                        IconButton(
                          onPressed: () {
                            showMonthPicker(
                              context: context,
                              initialDate: DateTime.now(),
                            ).then((date) {
                              if (date != null) {
                                StoresHub.historyStore.setMonth(date);
                              }
                            });
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ],
                    ),
                    DataTable(columns: [
                      const DataColumn(label: Text("Date")),
                      ...List.generate(
                          length,
                          (index) => DataColumn(
                              label: Text(activities[index].name ?? '')))
                    ], rows: [
                      ...history.entries.map<DataRow>((hist) {
                        return DataRow(cells: [
                          DataCell(Text(hist.key.day.toString())),
                          ...List.generate(
                              length,
                              (index) => DataCell(Text(displayDuration(hist
                                      .value
                                      .where((element) =>
                                          element.activityId ==
                                          activities[index].id)
                                      .firstOrNull
                                      ?.duration ??
                                  Duration()))))
                        ]);
                      }),
                      DataRow(cells: [
                        const DataCell(Text("Total")),
                        ...List.generate(
                            length,
                            (index) => DataCell(Text((displayDuration(
                                totalSums[activities[index].id] ??
                                    Duration())))))
                      ])
                    ]),
                  ],
                )));
      },
    );
  }
}
