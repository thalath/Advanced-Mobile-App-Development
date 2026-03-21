import 'package:flutter/material.dart';
import 'package:form_widget/widgets/form_widget.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormWidget(),
    );
  }
}