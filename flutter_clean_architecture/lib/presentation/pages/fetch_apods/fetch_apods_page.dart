import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/container_injection.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/presentation/bloc/fetch_apods/fetch_apods_bloc.dart';
import 'package:flutter_clean_architecture/presentation/pages/search/search_apod_page.dart';
import 'package:flutter_clean_architecture/presentation/widgets/core/apod_tile.dart';
import 'package:flutter_clean_architecture/presentation/widgets/today_apod/error_apod_widget.dart';

class FetchApodsPage extends StatefulWidget {
  const FetchApodsPage({super.key});

  @override
  State<FetchApodsPage> createState() => _FetchApodsPageState();
}

class _FetchApodsPageState extends State<FetchApodsPage> {
  final ScrollController _scrollController = ScrollController();
  late FetchApodsBloc _fetchApodsBloc;
  List<ApodEntity> apodList = [];

  @override
  void initState() {
    _fetchApodsBloc = getIt<FetchApodsBloc>();
    _fetchApodsBloc.input.add(MakeFetchApodsEvent());
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchApodsBloc.input.add(MakeFetchApodsEvent());
      }
    }); //identifica em que posição do scroll o usuário está e quando chega ao limite a lista recarrega.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: SearchApodPage());
          },
          icon: const Icon(Icons.search),
        )
      ]),
      body: StreamBuilder(
        stream: _fetchApodsBloc.stream,
        builder: (context, snapshot) {
          FetchApodsState? state = snapshot.data;
          Widget child = const CircularProgressIndicator();

          if (state is SuccesListFetchApods) {
            apodList.addAll(state.list);
          }

          if (state is ErrorFetchApodsState) {
            child = ErrorApodWidget(
              msg: state.msg,
              onRetry: () {
                apodList.clear();
                _fetchApodsBloc.input.add((MakeFetchApodsEvent()));
              },
            );
          }

          return RefreshIndicator(
              child: ListView.builder(
                controller: _scrollController, //aplica o controller no widget
                itemBuilder: ((context, index) {
                  if (index < apodList.length) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ApodTile(
                          apod: apodList[index],
                          onTap: () {
                            Navigator.pushNamed(context, "/apodView",
                                arguments: apodList[index]);
                          }),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: child,
                      ),
                    );
                  }
                }),
                itemCount: apodList.length + 1,
              ),
              onRefresh: () async {
                apodList.clear();
                _fetchApodsBloc.input.add(MakeFetchApodsEvent());
              });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmarks), label: "Bookmarks"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections), label: "Picture of The Day")
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.pushNamed(context, "/apodSave");
          }

          if (value == 2) {
            Navigator.pushNamed(context, "/apodToday");
          }
        },
      ),
    );
  }
}
