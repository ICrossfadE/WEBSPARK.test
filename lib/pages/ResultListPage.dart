import 'package:flutter/material.dart';
import 'package:webspark_test/constants/styles.dart';
import 'package:webspark_test/models/result_model.dart';
import 'package:webspark_test/services/ApiService.dart';

class ResultListPage extends StatefulWidget {
  final ApiService network;
  const ResultListPage({
    required this.network,
    super.key,
  });

  @override
  State<ResultListPage> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  @override
  Widget build(BuildContext context) {
    List<Result> items = widget.network.solutions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list page'),
        backgroundColor: kAppBarColor,
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding:
                  const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 5),
              child: ListTile(
                title: Text(
                  item.path,
                  textAlign: TextAlign.center,
                ),
                tileColor: Colors.black12,
              ),
            );
          },
        ),
      ),
    );
  }
}
