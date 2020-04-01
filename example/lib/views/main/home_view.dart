import 'package:example/modules/first_module.dart';
import 'package:example/modules/second_module.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView(this._user);

  final String _user;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Hello $_user"),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Choose your destiny!"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              FirstModule.routePaths.firstModuleView,
                            );
                          },
                          child: Text("First module"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              SecondModule.routePaths.secondModuleView,
                            );
                          },
                          child: Text("Second module"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
