import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/app_widget.dart';
import 'package:flutter_clean_architecture/container_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpContainer();
  runApp(const AppWidget());
}
