import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Websockets extends StatefulWidget {
  //channel from the websocket
  //taken from (websocket.org/echo.html)
  final WebSocketChannel channel = IOWebSocketChannel.connect("wss://echo.websocket.org/");

  @override
  _WebsocketsState createState() => _WebsocketsState(channel: channel);//adding parameter
}

class _WebsocketsState extends State<Websockets> {

  final WebSocketChannel channel;

  //constructor
  _WebsocketsState({this.channel}){
    channel.stream.listen((data) {
      setState(() {
        message.add(data);
      });
    });
  }
    //Controller to get text from text field
  final inputController = TextEditingController();
  //List to store messages
  List<String> message = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [

      Row(
        children: [
          Expanded(child:
          TextField(
            //attaching the controller
            controller: inputController,
            decoration: InputDecoration(
              labelText: "Send Message",
              border: OutlineInputBorder(),
            ),
          ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text("Send"),
              onPressed: (){
                if(inputController.text.isNotEmpty){
                  //adding data to the channel
                  channel.sink.add(inputController.text);

                  //clearing the textfield
                  inputController.text= "";
                }
              },
            ),
          ),
        ],
      ),
      Expanded(
          child: getMessageList(),
      ),
      ],
      ),
      )
    );

  }

    ListView getMessageList(){
      List<Widget> listWidget = [];

      for(String message in message){
        listWidget.add(ListTile(
          title: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
              ),
            ),
            color: Colors.teal[50],
            height: 60,
          ),
        ),);
      }
      return ListView(children: listWidget,);
  }

  @override
  void dispose(){
    inputController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
