import 'package:example/bloc/first_module/first_module_bloc.dart';
import 'package:flutter/material.dart';
import 'package:moduler_route/moduler_route.dart';

class FirstModuleView extends StatelessWidget {
  final _bloc = Inject.instance<FirstmoduleBloc>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("First module view"),
        ),
        body: Center(
          child: Text("First module view"),
        ),
      );
}
