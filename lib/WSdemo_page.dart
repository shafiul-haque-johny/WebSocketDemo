import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketDemo extends StatefulWidget {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

  WebSocketDemo({Key? key}) : super(key: key);

  @override
  State<WebSocketDemo> createState() => _WebSocketDemoState(channel: channel);
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final WebSocketChannel channel;
  final inputContruller = TextEditingController();
  List<String> messageList = [];

  @override
  void initState() {
    super.initState();
  }

  _WebSocketDemoState({required this.channel}) {
    channel.stream.listen((data) {
      setState(() {
        print(data);
        messageList.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputContruller,
                    decoration: InputDecoration(
                      labelText: 'Sent Messege',
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                      'Send',
                      style: TextStyle(fontSize: 48),
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      if (inputContruller.text.isNotEmpty) {
                        channel.sink.add(inputContruller.text);
                        inputContruller.text = '';
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: getMessageList(),
          ),
        ],
      ),
    );
  }

  ListView getMessageList() {
    List<Widget> listWidget = [];

    for (String message in messageList) {
      listWidget.add(ListTile(
        title: Container(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 22),
            ),
          ),
          color: Colors.teal[50],
          height: 60,
        ),
      ));
    }
    return ListView(
      children: listWidget,
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    inputContruller.dispose();
    //channel.sink.close();
    super.dispose();
  }
}
