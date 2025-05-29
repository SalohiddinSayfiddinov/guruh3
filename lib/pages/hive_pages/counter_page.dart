import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final Box counterBox = Hive.box('counterBox');

  int count = 0;

  void _increment() {
    setState(() {
      count++;
    });
    counterBox.put('count', count);
  }

  @override
  void initState() {
    super.initState();
    count = counterBox.get('count',defaultValue: 0);
  }

// widget tree, widget lifecycle
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          count.toString(),
          style: TextStyle(fontSize: 40.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _increment),
    );
  }
}
