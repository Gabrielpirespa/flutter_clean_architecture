import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/container_injection.dart';
import 'package:flutter_clean_architecture/core/date_convert.dart';
import 'package:flutter_clean_architecture/custom_colors.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/presentation/bloc/search/search_bloc.dart';
import 'package:flutter_clean_architecture/presentation/widgets/core/apod_tile.dart';
import 'package:flutter_clean_architecture/presentation/widgets/today_apod/error_apod_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SearchApodPage extends SearchDelegate {
  late SearchBloc _searchBloc;
  late SearchBloc _searchBlocHistory;
  final StreamController<SearchState> _stream = StreamController.broadcast();
  String _cacheQuery = "";

  List<ApodEntity> _cacheApodList = [];
  List<String> _searchHistoryList = [];
  PickerDateRange _chosenDate = PickerDateRange(DateTime.now(), DateTime.now());

  SearchApodPage() {
    _searchBloc = getIt<SearchBloc>();
    _searchBlocHistory = getIt<SearchBloc>();
    _searchBlocHistory.input.add(FetchHistorySearchEvent());
    _searchBloc.stream.listen((state) {
      _stream.add(state);
    });
    _searchBlocHistory.stream.listen((state) {
      if (state is SuccessHistorySearchState) {
        _searchHistoryList = state.list;
      }
    });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: TextTheme(titleLarge: TextStyle(color: CustomColors.white)),
      appBarTheme: AppBarTheme(backgroundColor: CustomColors.black),
      inputDecorationTheme:
          InputDecorationTheme(hintStyle: TextStyle(color: CustomColors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.vermilion)),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SfDateRangePicker(
              showActionButtons: true,
              maxDate: DateTime.now(),
              initialSelectedRange: _chosenDate,
              selectionMode: DateRangePickerSelectionMode.range,
              backgroundColor: CustomColors.black,
              todayHighlightColor: CustomColors.blue,
              headerHeight: 100,
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: TextStyle(
                  color: CustomColors.white,
                ),
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(
                    color: CustomColors.white,
                  ),
                ),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: TextStyle(
                  color: CustomColors.white,
                ),
              ),
              onSubmit: (dateRange) {
                if (dateRange is PickerDateRange) {
                  _chosenDate = dateRange;
                  if (dateRange.endDate != null) {
                    query =
                        "${DateConvert.dateToString(dateRange.startDate ?? DateTime(2023))}/${DateConvert.dateToString(dateRange.endDate ?? DateTime(2023))}";
                  } else {
                    query = DateConvert.dateToString(
                        dateRange.startDate ?? DateTime(2023));
                  }
                }
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ),
          );
        },
        icon: const Icon(Icons.calendar_month),
      ),
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty && query != _cacheQuery) {
      _searchBloc.input.add(FetchByDateRangeSearchEvent(query: query));
      _cacheQuery = query;
    }

    return Container(
      color: CustomColors.spaceBlue,
      child: StreamBuilder(
          stream: _stream.stream,
          builder: (context, snapshot) {
            SearchState? state = snapshot.data;

            if (state is LoadingSearchState) {
              return Center(
                child: CircularProgressIndicator(
                  color: CustomColors.white,
                ),
              );
            }

            if (state is ErrorSearchState) {
              return Center(
                child: ErrorApodWidget(
                  msg: state.msg,
                  onRetry: () {
                    _searchBloc.input
                        .add(FetchByDateRangeSearchEvent(query: query));
                  },
                ),
              );
            }

            if (state is SuccessListSearchState) {
              if (query.isNotEmpty) {
                if (!_searchHistoryList.contains(query)) {
                  _searchHistoryList.add(query);
                  _searchBlocHistory.input
                      .add(UpdateHistorySearchEvent(list: _searchHistoryList));
                }
              }

              _cacheApodList = state.list;
            }

            if (_cacheApodList.isEmpty) {
              return Center(
                child: ErrorApodWidget(
                  msg: "Sorry! We didn't find any content for this search",
                  onRetry: () {
                    _searchBloc.input
                        .add(FetchByDateRangeSearchEvent(query: query));
                  },
                ),
              );
            }

            return ListView.builder(
              itemCount: _cacheApodList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ApodTile(
                      apod: _cacheApodList[index],
                      onTap: () {
                        Navigator.pushNamed(context, "/apodView",
                            arguments: _cacheApodList[index]);
                      }),
                );
              },
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: CustomColors.spaceBlue,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: CustomColors.white.withOpacity(.7))),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Single day: YYYY-MM-DD\nRange of days: YYYY-MM-DD\nOr tap the calendar icon!",
                    style: TextStyle(color: CustomColors.white),
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder(
              stream: _stream.stream,
              builder: (context, snapshot) {
                SearchState? state = snapshot.data;

                if (state is LoadingSearchState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.white,
                    ),
                  );
                }

                if (state is SuccessHistorySearchState) {
                  _searchHistoryList = state.list;
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: _searchHistoryList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: CustomColors.white,
                          ),
                          onPressed: () {
                            _searchHistoryList.removeAt(index);
                            _searchBloc.input.add(UpdateHistorySearchEvent(
                                list: _searchHistoryList));
                          },
                        ),
                        title: Text(
                          _searchHistoryList[index],
                          style: TextStyle(color: CustomColors.white),
                        ),
                        onTap: () => query = _searchHistoryList[index],
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
