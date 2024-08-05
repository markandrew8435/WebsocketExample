import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final WebSocketChannel _channel;
  final _priceController = StreamController<double>();

  WebSocketService(String url) : _channel = WebSocketChannel.connect(Uri.parse(url)) {
    _channel.sink.add(jsonEncode({
      'op': 'subscribe',
      'args': ['trade:XBTUSD']
    }));

    _channel.stream.listen((message) {
      final data = parseMessage(message);
      if (data != null) {
        _priceController.sink.add(data);
      }
    });
  }

  Stream<double> get priceStream => _priceController.stream;

  double? parseMessage(String message) {

    final parsedMessage = jsonDecode(message);
    final List? data = parsedMessage["data"];

    if(data!=null && data.isNotEmpty){

      return (data.last['price']);

    }
    return null;

    
  }

  void dispose() {
    _priceController.close();
    _channel.sink.close();
  }
}


    // Subscribe to the XBTUSD instrument
   