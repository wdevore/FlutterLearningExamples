import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextListModel extends ChangeNotifier {
  List<String> lines = [
    'line1', //  <- window start
    'line2',
    'line3',
    'line4',
    'line5',
    'line6',
    // 'line7',
    // 'line8',
    // 'line9',
    // 'line10', // <- window end
    // 'line11',
    // 'line12',
    // 'line13',
    // 'line14',
  ];
  int lineCnt = 0;
  static const windowSize = 10;

  // Indices range from 0 to lines.length().
  int indexStart = 0;
  int indexEnd = windowSize;

  TextListModel() {
    lineCnt = lines.length;
    scrollToBottom();
  }

  void scrollToBottom() {
    indexStart = max(lines.length - windowSize, 0);
    indexEnd = lines.length;
  }

  void addLine(String text) {
    lineCnt++;
    text = '$text$lineCnt';
    lines.add(text);
    if (lines.length > 15) {
      lines.removeAt(0);
    }
    scrollToBottom();
    notifyListeners();
  }

  // Scrolling up means incrementing the index only if there are more
  // lines of than could be visible in the view.
  void scrollUp() {
    // Increment indices which moves the window.
    if (indexEnd == lines.length) {
      return; // Can't move
    }
    indexStart++;
    indexEnd++;
    notifyListeners();
  }

  void scrollDown() {
    // Increment indices which moves the window.
    if (indexStart == 0) {
      return; // Can't move
    }
    indexStart--;
    indexEnd--;
    notifyListeners();
  }
}

TextListModel gModel = TextListModel();

void main() {
  runApp(
    ChangeNotifierProvider.value(
      value: gModel,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Consumer<TextListModel>(
            builder:
                (BuildContext context, TextListModel value, Widget? child) {
              return TextScrollingWidget(
                model: value,
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Update queue model so scrolling widget updates.
              // Each line has a number. A visibility list is used to control
              // what is visible. Scrolling is simulated by updating the
              // visibility list.
              gModel.scrollUp();
            },
            child: const Text('up'),
          ),
          ElevatedButton(
            onPressed: () {
              // Update queue model so scrolling widget updates.
              // Each line has a number. A visibility list is used to control
              // what is visible. Scrolling is simulated by updating the
              // visibility list.
              gModel.scrollDown();
            },
            child: const Text('down'),
          ),
          ElevatedButton(
            onPressed: () {
              // Update queue model so scrolling widget updates.
              // Each line has a number. A visibility list is used to control
              // what is visible. Scrolling is simulated by updating the
              // visibility list.
              gModel.addLine('line');
            },
            child: const Text('add'),
          ),
        ],
      ),
    );
  }
}

class TextScrollingWidget extends StatefulWidget {
  const TextScrollingWidget({super.key, required this.model});

  final TextListModel model;

  @override
  State<TextScrollingWidget> createState() => _TextScrollingWidgetState();
}

class _TextScrollingWidgetState extends State<TextScrollingWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Iterable<String> lines = widget.model.lines
        .getRange(widget.model.indexStart, widget.model.indexEnd);

    controller.text = lines.join('\n');

    return TextField(
      controller: controller,
      maxLines: TextListModel.windowSize,
    );
  }
}
