import 'package:flutter/material.dart';
import 'package:timetracker/ui/app_body.dart';
import 'package:timetracker/ui/color_changer.dart';
import '../business_logic/boundary_services/store_provider.dart';

/// user interface that uses the [StoresHub]
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  dispose() {
    StoresHub.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: StoresHub.themeStore.stream,
        builder: (_, __) {
          return MaterialApp(
            title: 'Timetracker',
            debugShowCheckedModeBanner: false,
            theme: StoresHub.themeStore.getTheme,
            home: const MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Timetracking app",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          leading: ColorChanger(),
        ),
        body: Container(
            color: Theme.of(context).colorScheme.surface, child: AppBody()));
  }
}
