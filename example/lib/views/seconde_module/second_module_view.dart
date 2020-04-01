import 'package:example/bloc/second_module/second_module_bloc.dart';
import 'package:example/modules/second_module.dart';
import 'package:flutter/material.dart';
import 'package:moduler_route/moduler_route.dart';

class SecondmoduleView extends StatelessWidget {
  final _bloc = Inject.instance<SecondModuleBloc>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Second Module View"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                SecondModule.routePaths.secondModuleViewDetail,
              );
            },
            child: Text("View detail"),
          ),
        ),
      );
}
