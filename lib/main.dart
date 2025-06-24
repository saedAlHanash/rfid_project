import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return TestScan();
                },
              ));
            },
            child: Text('Go to scan page')),
      ),
    );
  }
}

class RfidReader {
  static const MethodChannel _channel = MethodChannel('rfid_channel');

  static Future<bool> init() async {
    try {
      return await _channel.invokeMethod('init');
    } on PlatformException catch (e) {
      print("Failed to init RFID: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> dispose() async {
    try {
      return await _channel.invokeMethod('dispose');
    } on PlatformException catch (e) {
      print("Failed to dispose RFID: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> readOrStop() async {
    try {
      return await _channel.invokeMethod('readOrStop');
    } on PlatformException catch (e) {
      print("Failed to toggle read: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> clear() async {
    try {
      return await _channel.invokeMethod('clear');
    } on PlatformException catch (e) {
      print("Failed to clear: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> getStatus() async {
    try {
      return await _channel.invokeMethod('getStatus');
    } on PlatformException catch (e) {
      print("Failed to get status: '${e.message}'.");
      return false;
    }
  }

  static Future<List<String>> getData() async {
    try {
      final data = await _channel.invokeMethod('getData');
      final l = List<String>.from(data);
      return l;
    } on PlatformException catch (e) {
      print("Failed to get data: '${e.message}'.");
      return ['error', '${e.message}'];
    }
  }

  static Future<bool> setReadType(int type) async {
    try {
      return await _channel.invokeMethod('setReadType', type);
    } on PlatformException catch (e) {
      print("Failed to set read type: '${e.message}'.");
      return false;
    }
  }
}

class TestScan extends StatefulWidget {
  const TestScan({super.key});

  @override
  State<TestScan> createState() => _TestScanState();
}

class _TestScanState extends State<TestScan> {
  var l = <String>[];
  var isInit = false;
  var isRead = false;
  Timer? t;

  void getStatus() {
    RfidReader.getStatus().then((value) {
      setState(() {
        isRead = value;
      });
    });
  }

  @override
  void dispose() {
    RfidReader.clear();
    RfidReader.dispose();
    t?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    Future(() async {
      await RfidReader.init();
      setState(() => isInit = true);
    });

    t = Timer.periodic(Duration(seconds: 2), (timer) async {
      getStatus();
      if (!isRead) return;
      l = (await RfidReader.getData());
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              RfidReader.readOrStop();
            },
            child: Text(isRead ? 'ايقاف' : 'بدأ'),
          ),
          Expanded(
            child: isInit
                ? ListView.builder(
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      return Text(l[index]);
                    },
                  )
                : CircularProgressIndicator.adaptive(),
          ),
        ],
      ),
    );
  }
}
