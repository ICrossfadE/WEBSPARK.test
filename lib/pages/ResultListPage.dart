import 'package:flutter/material.dart';
import 'package:webspark_test/constants/styles.dart';
import 'package:webspark_test/models/result_model.dart';
import 'package:webspark_test/pages/PreviewPage.dart';
import 'package:webspark_test/services/ApiService.dart';

class ResultListPage extends StatelessWidget {
  final ApiService network;
  const ResultListPage({
    required this.network,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Result> items = network.solutions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list page'),
        backgroundColor: kAppBarColor,
      ),
      body: ListView.builder(
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // Передаємо екземпляр класу
                  return PreviewPage(
                    indexPage: index,
                    network: network,
                  );
                }));
              },
            ),
          );
        },
      ),
    );
  }
}
