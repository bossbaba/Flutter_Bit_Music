import 'package:share/share.dart';

import '../components/toast.dart';
import '../components/loadingBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

///demo
/// ```
/// Navigator.of(context).pushNamed('/webview', arguments: {
///       'url': 'http://www.baidu.com',
///       'title': 'baidu',
///       'download': "http://mo.baidu.com/",
///        'shareUrl':'http://www.baidu.com'
///});
/// ```

class WebViewPage extends StatefulWidget {
  WebViewPage({Key key, this.webConfig}) : super(key: key);

  final Map webConfig;

  @override
  State<StatefulWidget> createState() {
    return WebViewPageBuilder();
  }
}

class WebViewPageBuilder extends State<WebViewPage> {
  final userAgent =
      'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  final flutterWebViewPlugin = FlutterWebviewPlugin();

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<double> _onProgressChanged;

  StreamSubscription<double> _onScrollYChanged;

  StreamSubscription<double> _onScrollXChanged;

  final _history = [];

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      this._launchInBrowser(widget.webConfig['download']);
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      print('the web view is destroy');
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add('onUrlChanged: $url');
        });
      }
    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
      if (mounted) {
        setState(() {
          _history.add('onProgressChanged: $progress');
        });
      }
    });

    _onScrollYChanged =
        flutterWebViewPlugin.onScrollYChanged.listen((double y) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in Y Direction: $y');
        });
      }
    });

    _onScrollXChanged =
        flutterWebViewPlugin.onScrollXChanged.listen((double x) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in X Direction: $x');
        });
      }
    });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if (state.url.split(':')[0] != 'http' &&
            state.url.split(':')[0] != 'https') {
          this._launchInBrowser(state.url);
        }
        setState(() {
          _history.add('onStateChanged: ${state.type} ${state.url}');
        });
      }
    });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      if (mounted) {
        setState(() {
          _history.add('onHttpError: ${error.code} ${error.url}');
        });
      }
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();

    flutterWebViewPlugin.dispose();

    super.dispose();
  }

  // ignore: prefer_collection_literals
  final Set<JavascriptChannel> _jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();

  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: widget.webConfig['url'],
        javascriptChannels: this._jsChannels,
        mediaPlaybackRequiresUserGesture: false,
        appBar: AppBar(
          title: Text(widget.webConfig['title']),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  var result = flutterWebViewPlugin.canGoBack();
                  result.then((_) {
                    flutterWebViewPlugin.goBack();
                  });
                }),
            IconButton(
                icon: Icon(Icons.autorenew),
                onPressed: () {
                  var result = flutterWebViewPlugin.reload();
                  result.then((value) {
                    Toast.show('刷新成功', context, bottom: 200);
                  });
                }),
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share(widget.webConfig['shareUrl']);
                }),
          ],
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                var result = flutterWebViewPlugin.close();
                result.then((_) {
                  Navigator.pop(context);
                });
              }),
        ),
        // withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Loading(),
        ));
  }
}
