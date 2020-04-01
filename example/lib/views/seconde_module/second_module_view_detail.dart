import 'package:example/bloc/second_module/second_module_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:moduler_route/moduler_route.dart';

class SecondModuleViewDetail extends StatelessWidget {
  final _bloc = Inject.instance<SecondModuleDetailBloc>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Second Module View Detail"),
        ),
        body: FutureBuilder(
          future: _bloc.repositoryInstanceTime(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return Text(snapshot.data);
          },
        ),
      );
}
