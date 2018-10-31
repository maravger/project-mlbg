import 'package:starter_app/app.dart';
import 'package:starter_app/app_state_container.dart';
import 'package:flutter/material.dart';

void main() {
  // Wrap your App in your new storage container
  runApp(new AppStateContainer(
    child: new AppRootWidget(),
  ));
}