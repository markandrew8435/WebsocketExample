import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebSocketDemo(),
    );
  }
}

class WebSocketDemo extends StatefulWidget {
  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('wss://www.bitmex.com/realtime'),
  );
  String lastReceivedPrice = 'Waiting for data...';

  @override
  void initState() {
    super.initState();
    // Subscribe to the XBTUSD instrument
    channel.sink.add(jsonEncode({
      'op': 'subscribe',
      'args': ['trade:XBTUSD']
    }));
    channel.stream.listen((data) {
      final decodedData = jsonDecode(data);
      if (decodedData['table'] == 'trade' && decodedData['data'] != null) {
        final tradeData = decodedData['data'][0];
        setState(() {
          lastReceivedPrice = tradeData['price'].toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BitMEX WebSocket Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text(lastReceivedPrice),
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
