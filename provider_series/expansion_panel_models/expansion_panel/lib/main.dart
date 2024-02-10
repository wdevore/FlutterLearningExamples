// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;

import 'package:expansion_panel/model.dart';
import 'package:expansion_panel/settings_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  SettingsModel settings = SettingsModel();

  setupWindow();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: settings,
      ),
      ChangeNotifierProvider.value(
        value: settings.envelopeSettings,
      ),
    ],
    child: const MyApp(),
  ));
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
      body: const SingleChildScrollView(
        child: EnvelopeExpansionPanelList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EnvelopeExpansionPanelList extends StatelessWidget {
  const EnvelopeExpansionPanelList({super.key});

  @override
  Widget build(BuildContext context) {
    final envelopeSettings = context.watch<EnvelopeSettings>();

    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: Colors.white,
      animationDuration: const Duration(milliseconds: 200),
      expansionCallback: (int index, bool isExpanded) {
        if (isExpanded) {
          envelopeSettings.expanded();
        } else {
          envelopeSettings.collapsed();
        }
      },
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: Colors.grey,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              isThreeLine: false,
              title: Container(
                alignment: Alignment.center,
                color: Colors.black26,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  envelopeSettings.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            );
          },
          body: Column(
            children: [
              // Wrap in ChangeNotifierProvider.value for attack
              // Have child use Consumer
              // SettingsSlider(
              //   min: envelopeSettings.attack.min,
              //   max: envelopeSettings.attack.max,
              //   title: envelopeSettings.attack.label,
              //   setFieldValue: (value) => envelopeSettings.attack.value = value,
              //   getFieldValue: () => envelopeSettings.attack.value,
              // ),

              ChangeNotifierProvider.value(
                value: envelopeSettings.attack,
                child: const SettingsSlider(),
              ),

              // Text('sustain'),
              // Text('punch'),
              // Text('decay'),
            ],
          ),
          isExpanded: envelopeSettings.isExpanded,
        ),
      ],
    );
  }

  void updateAttackFieldValue(dynamic value) {}
}
