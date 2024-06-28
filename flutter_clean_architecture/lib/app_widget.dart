import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/container_injection.dart';
import 'package:flutter_clean_architecture/route_generator.dart';
import 'package:flutter_clean_architecture/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astronomy Picture',
      onGenerateRoute: getIt<RouteGenerator>().generateRoute,
      initialRoute: "/",
      theme: CustomTheme.getTheme(),
    );
  }
}
