import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = StroiesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('dsfdsfdsfdsf'),
      ),
      body: _buildList(_bloc),
    );
  }

  Widget _buildList(StoriesBloc bloc) {
    return StreamBuilder(
        stream: bloc.topIds,
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return Text('Still waiting on Ids');
          }
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data![index].toString());
              });
        }

        //  ListView.builder(
        //   physics: BouncingScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return FutureBuilder(
        //         future: getFuture(),
        //         builder: ((context, snapshot) => SizedBox(
        //               height: 80,
        //               child: snapshot.hasData
        //                   ? Text('I visible $index')
        //                   : Text('You canr see me $index'),
        //             )));
        //   },
        //   itemCount: 1000,
        // ),
        );
  }

  Future getFuture() async {
    return Future.delayed(const Duration(seconds: 3), () => 'hi');
  }
}
