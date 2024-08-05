WebSocket Example
This Flutter application demonstrates how to use WebSocket to receive real-time data from BitMEX and display it on the screen. It utilizes the provider package for state management and web_socket_channel for WebSocket communication.

Features
Connects to the BitMEX WebSocket API.
Subscribes to real-time trade data for the XBTUSD instrument.
Displays the latest received price in a button.
Getting Started
Prerequisites
Make sure you have Flutter and Dart installed on your machine. You can find installation instructions on the Flutter website.

Installation
Clone the repository:

bash
Copy code
git clone https://github.com/yourusername/websocket_example.git
cd websocket_example
Install dependencies:

bash
Copy code
flutter pub get
Run the application:

bash
Copy code
flutter run
Project Structure
lib/main.dart: Entry point for the application.
lib/models/trade_data_model.dart: Contains the PriceProvider class for managing the price state.
lib/services/web_socket_service.dart: Contains the WebSocketService class for handling WebSocket communication.
Code Explanation
main.dart
Sets up the ChangeNotifierProvider for PriceProvider and initializes the WebSocket connection. The WebSocketDemo widget listens for price updates and displays them in a button.

PriceProvider
A ChangeNotifier class that holds the current price and notifies listeners when the price changes.

WebSocketService
Manages the WebSocket connection and handles incoming messages. It parses the JSON data to extract the latest price and streams it to subscribers.

Dependencies
flutter
provider: ^6.1.3
web_socket_channel: ^2.2.1
