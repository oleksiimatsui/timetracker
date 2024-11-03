import 'package:flutter/material.dart';
import 'package:timetracker/ui/app_body.dart';
import 'package:timetracker/ui/color_changer.dart';
import '../business_logic/boundary_services/store_provider.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: StoreProvider.themeState.stream,
        builder: (_, __) {
          return MaterialApp(
            title: 'Timetracker',
            debugShowCheckedModeBanner: false,
            theme: StoreProvider.themeState.getTheme,
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
