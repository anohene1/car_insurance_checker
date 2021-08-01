import 'package:flutter/material.dart';

import 'views/HomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InsuranceApp());
}

class InsuranceApp extends StatefulWidget {

  @override
  _InsuranceAppState createState() => _InsuranceAppState();
}

class _InsuranceAppState extends State<InsuranceApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}


