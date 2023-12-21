import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_service_planner/Response/ServiceResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class EventChatScreen extends StatefulWidget {
   EventChatScreen({super.key,required this.data});

  ServiceResponse data;
  @override
  State<EventChatScreen> createState() => _EventChatScreenState();
}

class _EventChatScreenState extends State<EventChatScreen> {

  TextEditingController messageCon = TextEditingController();
  FocusNode messageNode = FocusNode();


   List<ChatMessage> _messages = [
    ChatMessage(sender: 'User', text: 'Hello!',timestamp: DateTime.now()),
    ChatMessage(sender: 'Bot', text: 'Hi there!',timestamp: DateTime.now()),
    ChatMessage(sender: 'User', text: 'How are you?',timestamp: DateTime.now()),
    ChatMessage(sender: 'Bot', text: 'I\'m good, thanks!',timestamp: DateTime.now()),
    // Add more messages here
  ];

  ScrollController scrollCon = ScrollController();

  void launchMessagesApp() async {
    final phoneNumber = "+92336"; // Replace with your complete phone number

    final uri = Uri(scheme: 'sms', path: phoneNumber);
    final urlString = uri.toString();

    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      // Handle the error, for example, show an error message
      print('Could not launch the default messages app.');
    }
  }

  Stream<List<ChatMessage>> getMessagesStream(String chatId) {
    return FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatId) // Use the provided chatId to identify the specific chat
        .collection('Messages')
        .orderBy('timestamp', descending: false) // Order messages by timestamp
        .snapshots()
        .map((snapshot) {
      Timer(const Duration(milliseconds: 250), () { scrollCon.animateTo(scrollCon.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.ease); });

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ChatMessage(
          sender: data['sender'],
          text: data['text'],
          timestamp: data['timestamp'].toDate(),
        );
      }).toList();

    });
  }

  void _sendMessage(String chatId, String text) {
    final newMessage = ChatMessage(
      sender: 'User',
      text: text,
      timestamp: DateTime.now(),
    );

    FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatId) // Use the provided chatId to specify the chat to which the message belongs
        .collection('Messages')
        .add({
      'sender': newMessage.sender,
      'text': newMessage.text,
      'timestamp': newMessage.timestamp,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessagesStream("Chat1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xff09426d),
        elevation: 0.5,
        leadingWidth: 30,
        title: InkWell(
          onTap: ()
          {
            //Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => SingleServiceProvider(name: "Nafeel Techonza", image: "https://img.icons8.com/?size=512&id=0lg0kb05hrOz&format=png")));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                margin: const EdgeInsets.only(right: 10),
                width: kToolbarHeight-15,
                height: kToolbarHeight-15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  image:  DecorationImage(
                    image: NetworkImage("${widget.data.bannerImg}"),
                    fit: BoxFit.cover
                  )
                ),
              ),

               Text("${widget.data.venueName}",style: TextStyle(color: Colors.white,fontSize: 14),),
            ],
          ),
        ),
        actions:  [

          InkWell(
              onTap: () async {
                Uri phoneno = Uri.parse('tel:+1234566');
                if (await launchUrl(phoneno)) {
                  //dialer opened
                } else {
                  //dailer is not opened
                }
              },
              child: const Icon(Icons.phone_outlined,color: Colors.white,size: 20,)),

          const SizedBox(width: 10,),

          InkWell(
              onTap: ()async{
                Uri sms = Uri.parse('sms:101022?body=Hi, I am messaging from Multi Service Planner.');
                if (await launchUrl(sms)) {
                  //app opened
                }else{
                  //app is not opened
                }
              },
              child: const Icon(Icons.mail_outline,color: Colors.white,size: 20,)),

          const SizedBox(width: 10,),

          InkWell(
              onTap: ()
              {
                showModalBottomSheet(context: context,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                    builder: (BuildContext context)
                {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [

                        InkWell(
                          onTap: ()
                          {
                            setState(() {
                              _messages = [];
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            child: Text("Delete chat",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Color(
                                0xffff3636)),),
                          ),
                        ),

                        const SizedBox(height: 10,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: Text("Report user",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black.withOpacity(0.8)),),
                        ),

                        const SizedBox(height: 10,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: Text("Block user",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black.withOpacity(0.8)),),
                        ),

                        const SizedBox(height: 10,),

                        InkWell(
                          onTap: ()
                {
                  Navigator.pop(context);
                },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.black.withOpacity(0.8)),),
                          ),
                        ),


                      ],
                    ),
                  );
                });
              },
              child: const Icon(Icons.more_vert_outlined,color: Colors.white,size: 20,)),

          const SizedBox(width: 10,),

        ],
      ),


      body: Column(
        children: <Widget>[

          //View Add container
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.2),width: 0.5))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                //Event Image Con
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: kToolbarHeight,
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      image:  DecorationImage(
                          image: NetworkImage("${widget.data.bannerImg}"),
                          fit: BoxFit.cover
                      )
                  ),
                ),

                //Event Details
                Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("${widget.data.venueName}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8),fontSize: 14),),

                        const SizedBox(height: 5,),

                        Text('${widget.data.priceRangeStart} PKR',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8),fontSize: 12),),


                      ],
                    )
                ),


                Icon(Icons.keyboard_arrow_right,color: Colors.black.withOpacity(0.8),size: 30,)

              ],
            ),
          ),

          //StreamBuilder for messages
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,

              highlightColor: Colors.transparent,
              onTap: ()
              {
                messageNode.unfocus();


              },
              child: StreamBuilder<List<ChatMessage>>(
                stream: getMessagesStream("Chat1"), // Replace 'chatId' with the appropriate chat identifier
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: const CircularProgressIndicator(color: Color(0xff09426d),)); // Loading indicator
                  }

                  final messages = snapshot.data;

                  // Render your messages using _buildMessage function
                  return ListView.builder(
                    controller: scrollCon,
                    physics: const BouncingScrollPhysics(),
                    itemCount: messages?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildMessage(messages![index]);
                    },
                  );


                    ListView.builder(
                    itemCount: messages?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildMessage(messages![index]);
                    },
                  );
                },
              ),
            ),
          ),

          // Expanded(
          //   child: InkWell(
          //     splashColor: Colors.transparent,
          //
          //     highlightColor: Colors.transparent,
          //     onTap: ()
          //     {
          //       messageNode.unfocus();
          //
          //     },
          //     child: ListView.builder(
          //       controller: scrollCon,
          //       physics: const BouncingScrollPhysics(),
          //       itemCount: _messages.length,
          //       itemBuilder: (context, index) {
          //         return _buildMessage(_messages[index]);
          //       },
          //     ),
          //   ),
          // ),
          //

          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: message.sender == 'User' ?
        MainAxisAlignment.end
            :
        MainAxisAlignment.start,
        children: <Widget>[

          //Message container
          Container(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
            decoration: BoxDecoration(
              color: message.sender == 'User'
                  ? const Color(0xff09426d)
                  : const Color(0xff939393),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    message.text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 2,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(
                      DateFormat('h:mm a').format(DateTime.now()),
                      style: TextStyle(fontSize: 9, color: Colors.white),
                    ),

                    // Text("${DateTime.now().hour}:${DateTime.now().minute}",style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.6)),)

                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  // Implement the message composer here
  Widget _buildMessageComposer() {


    // You can use a TextField or TextFormField here for message input
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.attach_file,color: Color(0xff09426d),),
            onPressed: () {

              // Implement attachment functionality
            },
          ),
           Expanded(
            child: TextField(
              // onChanged: (string)
              // {
              //   setState(() {
              //     messageCon.text = string;
              //   });
              // },
              focusNode: messageNode,
              controller: messageCon,
              //textInputAction: TextInputAction.send,
              keyboardType: TextInputType.text,
              cursorColor: const Color(0xff09426d),
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
              // Handle text input and sending messages
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send,color: Color(0xff09426d),),
            onPressed: () {
              // Implement send message functionality

              _sendMessage("Chat1",messageCon.text);

              setState(() {
                _messages.add(ChatMessage(text: messageCon.text, sender: "User",timestamp: DateTime.now()));

                messageCon.text = "";
              });

              Timer(const Duration(milliseconds: 250), () { scrollCon.animateTo(scrollCon.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.ease); });
            },
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final String sender;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.sender,required this.timestamp});
}