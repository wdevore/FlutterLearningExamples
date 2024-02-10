// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;

import 'package:expansion_panel/envelope_expansion_panel_list.dart';
import 'package:expansion_panel/frequency_expansion_panel_list.dart';
import 'package:expansion_panel/model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

SettingsModel _settings = SettingsModel();

void main() {
  setupWindow();
  runApp(const MyApp());

  // Instead of providing notifiers at this level
  // I do below closer to the actual expansion panel.
  // The downside is the that model is now global to the
  // package.

  // However, the "SettingsModel" could be provided
  // at this level.
  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider.value(
  //       value: settings.envelopeSettings,
  //     ),
  //     ChangeNotifierProvider.value(
  //       value: settings.frequencySettings,
  //     ),
  //   ],
  //   child: const MyApp(),
  // ));
}

const double windowWidth = 360;
const double windowHeight = 640;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Counter');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final envelope = context.select<SettingsModel, EnvelopeSettings>(
    //     (settings) => settings.envelopeSettings);
    // final envelope = context.watch<SettingsModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: ListView(children: [
        ChangeNotifierProvider.value(
          value: _settings.envelopeSettings,
          child: const EnvelopeExpansionPanelList(),
        ),
        // EnvelopeExpansionPanelList(),
        ChangeNotifierProvider.value(
          value: _settings.frequencySettings,
          child: const FrequencyExpansionPanelList(),
        ),
        // FrequencyExpansionPanelList(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
