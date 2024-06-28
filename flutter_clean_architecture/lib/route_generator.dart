import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/presentation/pages/core/see_full_image.dart';
import 'package:flutter_clean_architecture/presentation/pages/fetch_apods/fetch_apods_page.dart';
import 'package:flutter_clean_architecture/presentation/pages/today_apod/apod_today_page.dart';
import 'package:flutter_clean_architecture/presentation/pages/today_apod/apod_view_page.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: _mapRouteName(settings.name, settings.arguments));
  }

  Widget Function(BuildContext) _mapRouteName(String? name, Object? arguments) {
    switch (name) {
      case "/":
        return (_) => const FetchApodsPage();
      case "/apodView":
        if (arguments is ApodEntity) {
          return (_) => ApodViewPage(
                apod: arguments,
              );
        } else {
          return (_) => _errorPage();
        }
      case "/apodToday":
        return (_) => const ApodTodayPage();
      case "/fullImage":
        if (arguments is String?) {
          return (_) => SeeFullImage(
                url: arguments ?? "",
              );
        } else {
          return (_) => _errorPage();
        }
      default:
        return (_) => _errorPage();
    }
  }

  Widget _errorPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Navigation Error"),
      ),
    );
  }
}
