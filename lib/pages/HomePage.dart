import 'package:flutter/material.dart';
import 'package:webspark_test/constants/styles.dart';
import 'package:webspark_test/pages/ProcessPage.dart';
import 'package:webspark_test/services/ApiService.dart';
import 'package:webspark_test/widgets/SearchFeild.dart';
import 'package:webspark_test/widgets/WidthButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService network = ApiService();
  String? validationMessage;
  bool _isGetting = false;

  Future<void> getTask() async {
    if (validationMessage == 'API Url is valid') {
      setState(() {
        _isGetting = true;
      });
      await network.getData();
      setState(() {
        _isGetting = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        // Передаємо екземпляр класу
        return ProcessPage(network: network);
      }));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
        backgroundColor: kAppBarColor,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text('Set valid API base URL in order continue'),
                  const SizedBox(height: 10),
                  SearchField(
                    hintText: 'Enter API URL',
                    onChanged: (valueUrl) {
                      setState(() {
                        if (valueUrl.isEmpty && valueUrl == '') {
                          validationMessage = null;
                          network.setUrl('');
                        } else if (network.isValidUrl(valueUrl)) {
                          validationMessage = 'API Url is valid';
                          network.setUrl(valueUrl);
                        } else {
                          validationMessage = 'API Url is not valid';
                        }
                      });
                    },
                  ),
                  if (validationMessage != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      '$validationMessage',
                      style: validationMessage == 'API Url is valid'
                          ? kValid
                          : kNotValid,
                    ),
                  ]
                ],
              ),
              WidthButton(
                buttonText:
                    _isGetting ? 'Getting Task' : 'Start counting process',
                buttonColor: (validationMessage == 'API Url is valid')
                    ? kActveButtonColor
                    : kDisabledButtonColor,
                buttonTextStyle: (validationMessage == 'API Url is valid')
                    ? kActiveStyle
                    : kDisabledStyle,
                buttonIcon: _isGetting ? null : Icons.trending_flat,
                iconColor: (validationMessage == 'API Url is valid')
                    ? kActveColor
                    : kDisabledColor,
                onPressed: getTask,
              )
            ],
          )),
    );
  }
}
