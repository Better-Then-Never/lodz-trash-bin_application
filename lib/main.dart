import 'package:flutter/material.dart';

void main() {
  runApp(const LodzTrashBinApp());
}

class LodzTrashBinApp extends StatelessWidget {
  const LodzTrashBinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lodz trash bin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 34, 255, 64),
        ),
      ),
      home: const PlaceholderPage(title: 'Lodz trash bin'),
    );
  }
}

class PlaceholderPage extends StatefulWidget {
  const PlaceholderPage({super.key, required this.title});
  final String title;

  @override
  State<PlaceholderPage> createState() => _PlaceholderPageState();
}

class _PlaceholderPageState extends State<PlaceholderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center)),
    );
  }
}
