import 'package:app_test_1/bloc/response_bloc.dart';
import 'package:app_test_1/bloc/response_event.dart';
import 'package:app_test_1/bloc/response_state.dart';
import 'package:app_test_1/model/response.dart';
import 'package:app_test_1/presentation/common_widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

String? title;

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    final responsBloc = BlocProvider.of<ResponseBloc>(context);
    responsBloc.add(FetchDataEvent());
  }

  Widget _buildCard(List<Rows>? row) {
    return Column(
      children: [
        ...row!.map(
          (value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: TileCard(
              title: value.title,
              description: value.description,
              imageUrl: value.imageHref,
            ),
          ),
        ),
      ],
    );
  }

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    /// monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    /// if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    /// monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    /// if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: BlocBuilder<ResponseBloc, ResponseState>(
            builder: (context, state) {
              final responsBloc = BlocProvider.of<ResponseBloc>(context);
              return Container(
                child: responsBloc.data.title == null
                    ? const CircularProgressIndicator()
                    : Row(
                        children: <Widget>[
                          Text(
                            responsBloc.data.title.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: BlocBuilder<ResponseBloc, ResponseState>(
            builder: (context, state) {
              final responsBloc = BlocProvider.of<ResponseBloc>(context);

              return responsBloc.data.rows == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: _buildCard(responsBloc.data.rows),
                    );
            },
          ),
        ),
      ),
    );
  }
}
