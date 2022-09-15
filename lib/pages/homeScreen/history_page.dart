import 'package:flutter/material.dart';

import '../../utility/my_constant.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var contrianerRadius = Radius.circular(30);
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyConstant.primary,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('History'),
        backgroundColor: MyConstant.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  // '${NumberFormat('#,###').format(balance)} ₭',
                  '',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: contrianerRadius,
                  topRight: contrianerRadius,
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'ປະຫວັດການຈ່າຍ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansLao',
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: const <Widget>[
                          bluidHistory(
                            title: 'ຊຳລະຄ່າໄຟຟ້າ',
                            description: 'ຊຳລະໄປຫາ xxxxxxxxxxxxxxx',
                          ),
                          bluidHistory(
                            title: 'ຊຳລະຄ່າໄຟຟ້າ',
                            description: 'ຊຳລະໄປຫາ xxxxxxxxxxxxxxx',
                          ),
                          bluidHistory(
                            title: 'ຊຳລະຄ່າໄຟຟ້າ',
                            description: 'ຊຳລະໄປຫາ xxxxxxxxxxxxxxx',
                          ),
                          bluidHistory(
                            title: 'ຊຳລະຄ່າໄຟຟ້າ',
                            description: 'ຊຳລະໄປຫາ xxxxxxxxxxxxxxx',
                          ),
                          bluidHistory(
                            title: 'ຊຳລະຄ່າໄຟຟ້າ',
                            description: 'ຊຳລະໄປຫາ xxxxxxxxxxxxxxx',
                          ),
                          bluidHistory(
                            title: 'ຊຳລະຄ່າໄຟຟ້າ',
                            description: 'ຊຳລະໄປຫາ xxxxxxxxxxxxxxx',
                          ),
                          bluidHistory(
                            title: 'ຊຳລະຄ່າໄຟຟ້າ',
                            description: 'ຊຳລະໄປຫາ xxxxxxxxxxxxxxx',
                          ),
                          bluidHistory(
                            title: 'ຊຳລະຄ່າໄຟຟ້າ',
                            description: 'ຊຳລະໄປຫາ xxxxxxxxxxxxxxx',
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class bluidHistory extends StatelessWidget {
  const bluidHistory({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'NotoSansLao',
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'NotoSansLao',
          ),
        ),
        // trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
