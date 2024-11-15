import 'package:flutter/material.dart';
import 'package:webspark_test/constants/styles.dart';
import 'package:webspark_test/widgets/WidthButton.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Process page'),
          backgroundColor: kAppBarColor,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Center(
            child: Column(
              children: [
                const Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          'All calculations has finished, you can send result to server'),
                    ],
                  ),
                ),
                WidthButton(
                  buttonText: 'Send result to server',
                  buttonIcon: Icons.trending_flat,
                  buttonColor: kActveButtonColor,
                  buttonTextStyle: kActiveStyle,
                  onPressed: () {
                    print('click');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

// child: Column(
