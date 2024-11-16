import 'package:flutter/material.dart';
import 'package:webspark_test/constants/styles.dart';

class PreviewPage extends StatefulWidget {
  final int? indexPage;

  const PreviewPage({
    super.key,
    required this.indexPage,
  });

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview page ${widget.indexPage}'),
        backgroundColor: kAppBarColor,
      ),
    );
  }
}
