// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:expansion_panel/model.dart';
import 'package:expansion_panel/settings_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrequencyExpansionPanelList extends StatelessWidget {
  const FrequencyExpansionPanelList({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<FrequencySettings>();

    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: Colors.white,
      animationDuration: const Duration(milliseconds: 200),
      expansionCallback: (int index, bool isExpanded) {
        if (isExpanded) {
          settings.expanded();
        } else {
          settings.collapsed();
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
                padding: const EdgeInsets.only(top: 2, bottom: 2),
                child: Text(
                  settings.title,
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
              ChangeNotifierProvider.value(
                value: settings.frequency,
                child: const SettingsSlider(),
              ),
              ChangeNotifierProvider.value(
                value: settings.minCutoff,
                child: const SettingsSlider(),
              ),
              ChangeNotifierProvider.value(
                value: settings.slide,
                child: const SettingsSlider(),
              ),
              ChangeNotifierProvider.value(
                value: settings.deltaSlide,
                child: const SettingsSlider(),
              ),
            ],
          ),
          isExpanded: settings.isExpanded,
        ),
      ],
    );
  }

  void updateAttackFieldValue(dynamic value) {}
}
