import 'package:flutter/material.dart';
import 'package:mmoney_consumer/utility/my_constant.dart';
import 'package:mmoney_consumer/widgets/show_image.dart';

class SliverApp extends StatelessWidget {
  const SliverApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // leading: Icon(Icons.menu),
            // title: Text('S L I V E R'),
            expandedHeight: 300,
            floating: false,
            pinned: true,
            // snap: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('S L I V E R'),
              background: Image.asset(
                MyConstant.banner01,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverGrid.count(
            crossAxisCount: 1,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
            children: <Widget>[
              Container(
                child: Card(
                  child: ListTile(
                    leading: FlutterLogo(size: 56.0),
                    title: Text(
                      'title',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSansLao',
                      ),
                    ),
                    subtitle: Text(
                      'description',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'NotoSansLao',
                      ),
                    ),
                    // trailing: Icon(Icons.more_vert),
                  ),
                ),
              ),
              Container(
                child: Card(
                  child: ListTile(
                    leading: FlutterLogo(size: 56.0),
                    title: Text(
                      'title',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSansLao',
                      ),
                    ),
                    subtitle: Text(
                      'description',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'NotoSansLao',
                      ),
                    ),
                    // trailing: Icon(Icons.more_vert),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
