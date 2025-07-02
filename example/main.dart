import 'package:flutter/material.dart';
import 'package:progressive_fab/progressive_fab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progressive FAB Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FabDemoPage(),
    );
  }
}

class FabDemoPage extends StatefulWidget {
  const FabDemoPage({super.key});

  @override
  State<FabDemoPage> createState() => _FabDemoPageState();
}

class _FabDemoPageState extends State<FabDemoPage> {
  double _progress = 0;

  void _incrementProgress() {
    setState(() {
      _progress += 10;
      if (_progress > 100) _progress = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progressive FAB Example')),
      body: Center(
        child: Text('Progress: \\${_progress.toInt()}%', style: const TextStyle(fontSize: 24)),
      ),
      floatingActionButton: ProgressiveFAB(
        progress: _progress,
        onPressed: _incrementProgress,
        icon: const Icon(Icons.add),
        fabColor: Colors.blue,
        progressColor: Colors.green,
        borderColor: Colors.grey.shade300,
        iconColor: Colors.white,
        size: 80,
        padding: 10,
      ),
    );
  }
}

