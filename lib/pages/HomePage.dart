import 'package:flutter/material.dart';
import 'package:webspark_test/constants/styles.dart';
import 'package:webspark_test/widgets/SearchFeild.dart';
import 'package:webspark_test/widgets/WidthButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Text('Set valid API base URL in order continue'),
                  SizedBox(
                    height: 10,
                  ),
                  SearchField(
                    hintText: 'API URL',
                  ),
                ],
              ),
              WidthButton(
                buttonText: 'Start counting process',
                buttonColor: Colors.deepPurple,
                buttonTextStyle: kButtonStyle,
                buttonIcon: Icons.trending_flat,
                onPressed: () {
                  print('click');
                },
              )
            ],
          )),
    );
  }
}
