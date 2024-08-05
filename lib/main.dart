import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_example/models/trade_data_model.dart';

import 'package:websocket_example/services/web_socket_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((BuildContext context) => PriceProvider()),
      child: MaterialApp(
        home: WebSocketDemo(),
      ),
    );

  }
}

class WebSocketDemo extends StatefulWidget {
  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  late WebSocketService _webSocketService;
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('wss://www.bitmex.com/realtime'),
  );
  String lastReceivedPrice = 'Waiting for data...';

  @override
  void initState() {
    super.initState();

    _webSocketService = WebSocketService('wss://www.bitmex.com/realtime');

    _webSocketService.priceStream.listen((price) {
      final priceProvider = Provider.of<PriceProvider>(context, listen: false);
      priceProvider.price = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BitMEX WebSocket Demo'),
      ),
      body: Center(
        child: Consumer<PriceProvider>(
          builder: (context, priceProvider, child) {
            return ElevatedButton(
              onPressed: () {},
              child: Text('Price: \$${priceProvider.price.toStringAsFixed(2)}'),
            );
          },
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
