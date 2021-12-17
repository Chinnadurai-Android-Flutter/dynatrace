import 'dart:async';

import 'package:dynatrace_flutter_plugin/dynatrace_flutter_plugin.dart';
import 'package:flutter/material.dart';

void main() {
  // Dynatrace().startWithoutWidget(
  //     configuration: const Configuration(
  //         reportCrash: true,
  //         monitorWebRequest: true,
  //         logLevel: LogLevel.Info,
  //         certificateValidation: true,
  //         userOptIn: false));
  // runApp(const MyApp());

  // Dynatrace().start(const MyApp())
  runZonedGuarded<Future<void>>(() async {
    Dynatrace().startWithoutWidget();
    runApp(const MyApp());
  }, Dynatrace().reportZoneStacktrace);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Dynatrace()
                    .enterAction("homeAddingCalculationFloating tapped",
                        platform: Platform.Android)
                    .leaveAction();
              },
              child: const Text('Trace'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                DynatraceRootAction myAction = Dynatrace().enterAction(
                    "reportStringButton tapped",
                    platform: Platform.Android);
                myAction.reportStringValue(
                    "action_reporting_string", "reportingString");
                myAction.leaveAction();
              },
              child: const Text('Report String'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                DynatraceRootAction myAction =
                    Dynatrace().enterAction("reportStringButton tapped");
                myAction.reportError("action_reporting_error_code", 404,
                    platform: Platform.Android);
                myAction.leaveAction();
              },
              child: const Text('Report Error'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                DynatraceRootAction myAction =
                    Dynatrace().enterAction("reportStringButton tapped");
                myAction.reportEvent("action_reporting_event",
                    platform: Platform.Android);
                myAction.leaveAction();
              },
              child: const Text('Report Event'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Dynatrace().reportZoneStacktrace(
                    'dynamicError', StackTrace.current,
                    platform: Platform.Android);
              },
              child: const Text('Report Zone Stacktrace'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Dynatrace().setGPSLocation(13.257354, 80.9426875,
                    platform: Platform.Android);
              },
              child: const Text('Set GPS Location'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                Dynatrace().applyUserPrivacyOptions(
                    UserPrivacyOptions(DataCollectionLevel.Performance, true),
                    platform: Platform.Android);
              },
              child: const Text('Apply User Privacy Options'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                Dynatrace()
                    .identifyUser('Chinnadurai', platform: Platform.Android);
              },
              child: const Text('Identify User'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                Dynatrace().reportCrash(
                    'errorName', 'reason of crash', 'location for stacktrace');
              },
              child: const Text('Report Crash'),
            ),
          ],
        ),
      ),
    );
  }
}
