import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _url = Completer<String>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _url.future,
          builder: (context, AsyncSnapshot<String> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snap.connectionState == ConnectionState.done) {
              if (snap.hasError) {
                return Center(child: Text('${snap.error}'));
              }
              return Text(snap.data.toString());
            }
            return SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var url = await showDialog<String>(
              context: context,
              builder: (_) => Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: WebView(
                        initialUrl:
                            'http://jiexi.kingsnug.cn/tx.php?url=http://v.qq.com/x/page/w0019k37ecc.html?ptag=360kan.cartoon.free',
                        javascriptMode: JavascriptMode.unrestricted,
                        onRequest2: (Map<String, dynamic> req) async {
                          print('======================================');
                          print(req);
                          print('======================================');
                        },
                      ),
                    ),
                  ));
          print(url);
          if (!_url.isCompleted) _url.complete(url);
        },
      ),
    );
  }
}
