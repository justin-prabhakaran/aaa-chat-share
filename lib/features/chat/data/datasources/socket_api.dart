import 'package:socket_io_client/socket_io_client.dart';

class SocketApi {
  late Socket socket;
  SocketApi() {
    print('Creating new instance !!!!!!!');
    socket = io(
      Uri.parse('http://localhostL:1234'),
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );
  }
}
