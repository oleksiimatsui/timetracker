import 'package:flutter/material.dart';

import '../business_logic/boundary_services/store_provider.dart';


class NewActivityWidget extends StatefulWidget {
  const NewActivityWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewActivityState();
  }
}

class _NewActivityState extends State<NewActivityWidget> {
  bool dialogOpen = false;
  bool loading = false;
  String? name;

  addActivity() async {
    setState(() {
      loading = true;
    });
    try {
      await StoreProvider.activitiesState.addActivity(name!);
    } finally {
      setState(() {
        dialogOpen = false;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dialogOpen == false) {
      return TextButton(
          onPressed: () => setState(() {
                dialogOpen = true;
              }),
          child: Text('Add activity!'));
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).cardColor),
      width: 284,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: TextField(onChanged: (text) {
              setState(() {
                name = text;
              });
            }),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Theme.of(context).colorScheme.surface),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TextField()
                TextButton(
                    onPressed: name == null || name == "" || loading
                        ? null
                        : addActivity,
                    child: Text('Submit')),
                TextButton(
                    onPressed: loading
                        ? null
                        : () => setState(() {
                              dialogOpen = false;
                            }),
                    child: Text('Cancel'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
