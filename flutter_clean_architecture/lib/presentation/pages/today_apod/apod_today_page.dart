import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/container_injection.dart';
import 'package:flutter_clean_architecture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:flutter_clean_architecture/presentation/pages/today_apod/apod_view_page.dart';
import 'package:flutter_clean_architecture/presentation/widgets/today_apod/error_apod_widget.dart';

class ApodTodayPage extends StatefulWidget {
  const ApodTodayPage({super.key});

  @override
  State<ApodTodayPage> createState() => _ApodTodayPageState();
}

class _ApodTodayPageState extends State<ApodTodayPage> {
  late TodayApodBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<TodayApodBloc>();
    _bloc.input.add(FetchApodTodayEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TodayApodState>(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          TodayApodState? state = snapshot.data;
          Widget body = Container();

          if (state is LoadingTodayApodState) {
            body = const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorTodayApodState) {
            body = Center(
              child: ErrorApodWidget(
                msg: state.message,
                onRetry: () {
                  _bloc.input.add(FetchApodTodayEvent());
                },
              ),
            );
          }
          if (state is SuccesTodayApodState) {
            return ApodViewPage(apod: state.apod);
          }

          return Scaffold(
            body: body,
          );
        });
  }
}
