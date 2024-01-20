import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:url_launcher/url_launcher.dart';

class NoiseApp extends StatefulWidget {
  @override
  _NoiseAppState createState() => _NoiseAppState();
}

class _NoiseAppState extends State<NoiseApp> {
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  double? maxDB;
  double? meanDB;
  List<_ChartData> chartData = <_ChartData>[];
  late int previousMillis;

  @override
  void initState() {
    super.initState();
    _noiseMeter = NoiseMeter(onError);
    start(); // Start recording immediately
  }

  void onData(NoiseReading noiseReading) {
    maxDB = noiseReading.maxDecibel;
    meanDB = noiseReading.meanDecibel;

    chartData.add(
      _ChartData(
        maxDB,
        meanDB,
        ((DateTime.now().millisecondsSinceEpoch - previousMillis) / 1000)
            .toDouble(),
      ),
    );

    // Check if dBs are more than 40 and show 'shhh' message
    if (maxDB != null && maxDB! > 40) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('shhh'),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 2500),
        ),
      );
    }
  }

  void onError(Object e) {
    print(e.toString());
  }

  void start() async {
    previousMillis = DateTime.now().millisecondsSinceEpoch;
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = Theme.of(context).brightness == Brightness.light;

    if (chartData.length >= 25) {
      chartData.removeAt(0);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _isDark ? Colors.green : Colors.green.shade800,
        title: Text('dB Sound Meter'),
        actions: [
          IconButton(
              tooltip: 'Source code on GitHub',
              icon: Icon(Icons.code_outlined),
              onPressed: openGithub),
          IconButton(
            tooltip: 'Copy value to clipboard',
            icon: Icon(Icons.copy),
            onPressed: maxDB != null ? () => copyValue(_isDark) : null,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  maxDB != null ? maxDB!.toStringAsFixed(2) : 'Press start',
                ),
              ),
            ),
            Text(
              'Mean: ${meanDB?.toStringAsFixed(2) ?? 'Awaiting data'}',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            ),
            SizedBox(
              height: 68,
            ),
          ],
        ),
      ),
    );
  }

  void copyValue(bool theme) {
    Clipboard.setData(
      ClipboardData(
        text: 'It\'s about ${maxDB!.toStringAsFixed(1)}dB loudness',
      ),
    ).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 2500),
          content: Row(
            children: [
              Icon(
                Icons.check,
                size: 14,
                color: theme ? Colors.white70 : Colors.black,
              ),
              SizedBox(width: 10),
              Text('Copied'),
            ],
          ),
        ),
      );
    });
  }

  void openGithub() async {
    const url = 'https://github.com/iqfareez/noise_meter_flutter';
    try {
      await launch(url);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _ChartData {
  final double? maxDB;
  final double? meanDB;
  final double frames;

  _ChartData(this.maxDB, this.meanDB, this.frames);
}
