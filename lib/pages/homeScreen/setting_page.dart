import 'package:flutter/material.dart';

import '../../utility/my_constant.dart';

class SetingPage extends StatefulWidget {
  const SetingPage({Key? key}) : super(key: key);

  @override
  State<SetingPage> createState() => _SetingPageState();
}

class _SetingPageState extends State<SetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        backgroundColor: MyConstant.primary,
      ),
    );
  }
}
