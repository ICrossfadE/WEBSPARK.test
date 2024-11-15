import 'package:flutter/material.dart';
import 'package:webspark_test/constants/styles.dart';
import 'package:webspark_test/pages/ResultListPage.dart';
import 'package:webspark_test/services/ApiService.dart';
import 'package:webspark_test/widgets/WidthButton.dart';

class ProcessPage extends StatefulWidget {
  final ApiService? network;
  const ProcessPage({
    this.network,
    super.key,
  });

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  String _errorMessage = '';
  bool _isLoading = false;
  bool _isSuccess = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    // Запускаєм анімацію після отримання данних
    _startAnimation();
  }

  // Відправляєм результат
  Future<void> _postResult() async {
    _isSending = true;
    setState(() {});

    try {
      if (_isSuccess) {
        await widget.network!.postData();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          // Передаємо екземпляр класу
          return ResultListPage(network: widget.network!);
        }));
      } else {
        null;
      }
    } catch (e) {}
  }

  Future<void> _startAnimation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await widget.network!.startAlgorithm();
      _controller.forward(); // Почати анімацію прогресу

      _controller.addListener(
        () {
          setState(() {});
        },
      );

      // Затримка для закінчення анімації
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error';
      });
    }
  }

  // Варіанти подій для кнопки
  String? showEventTextButton() {
    if (_isLoading) {
      return 'Calculations';
    } else if (!_isLoading && _isSuccess) {
      return 'Send result to server';
    } else if (_isSending && !_isLoading && _isSuccess) {
      return 'Loaded';
    } else {
      return _errorMessage;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'All calculations has finished, you can send result to server',
                        style: kProgresTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(_progressAnimation.value * 100).toInt()}%',
                        style: kProgresTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator(
                          value: _progressAnimation.value,
                          strokeWidth: 8,
                        ),
                      )
                    ],
                  ),
                ),
                WidthButton(
                  buttonText: (_isSending && !_isLoading && _isSuccess)
                      ? 'Loaded'
                      : showEventTextButton(),
                  buttonIcon: _isSuccess ? Icons.trending_flat : null,
                  iconColor: _isSuccess ? kActveColor : kDisabledColor,
                  buttonColor:
                      _isSuccess ? kActveButtonColor : kDisabledButtonColor,
                  buttonTextStyle: _isSuccess ? kActiveStyle : kDisabledStyle,
                  onPressed: _postResult,
                ),
              ],
            ),
          ),
        ));
  }
}
