import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _authFireStore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  final messageTextController = TextEditingController();

  String message;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // this method the user need to click on a random button to pull all the data from the database in the firestore.
  void getMessage() async {
    var messages = await _authFireStore.collection('messages').getDocuments();
    // it is a future query snapshot, the query snapshot is the data type from the firebase,
    // and it is a snapshot of data that we have it in the current collection.

    for (var message in messages.documents) {
      // if we tap on these messages, and go into the document, we can see that we can get a list of the documents snapshots
      //these documents are refer to the documents which are belong to the messages collection in the database of cloud fire store.
      //As the messages.documents is a list, so in order to view individual item/document snapshot in the list, we will need to use a for loop method.

      print(message.data);
      // here is where will print all the messages in the messages collection.
      //Here is where we will print the document snapshot.data, which will return a key value pair.
      // The String will refer to the field and the value will refer to the text.

    }
    //The whole code is working at the moment by get hold all the documents in the messages collection.
    //It create single message out of all the messages documents.
    //We print out each one of those and the data which is associated with it.
  }

  // the method will allow the data to be automatically pushed in the chat screen from the database in the fire store.
  // the method will also be asynchronous method as it will listen for the stream of the messages that is come from the firebase.

  void messagesStream() async {
    await for (var snapshot
        in _authFireStore.collection('messages').snapshots()) {
      // Message stream will use a different method which is a method called snapshot, and
      // this method will return a stream of query snapshot instead of returning the future query snapshot.
      //
      // This is like a string of future, which is a whole bunch of future.
      // at anytime a new messages will be created and be added in to the message collection
      // so we have to loop through all the snapshots which is basically kind of like a list of future objects.
      //
      // By subscribing to this stream, it will listen all the changes that happen in the particular collection.
      // when there is a new document snapshot added in the messages collection, I am now subscribed, and will be notified of any new results.
      for (var message in snapshot.documents) {
        // this is similar to the future query snapshot, which it is a list of document snapshot.
        //so I have to loop through the list of document of the document snapshot.
        print(message.data);
        // compare to the future query snapshot, which will pull the data from the database in the fire store,
        // the stream query snapshot will effectively push the data from the database.
        //Hence in the stream query snapshot, the app is listening for change to the firebase
        // firebase is notifying the app of any new messages through the stream of data snapshot.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // messagesStream();
                // the moment I hit on this button, it wil start subscribing to the messages in the messages collection,
                // and the messages will be printed out in the console
                //
                //In the database of the fire store, the moment that the user manually create the document, and type the new field and value
                //once the user click save, the document will be saved into the messages collection, and it is done through the firebase dashboard,
                //but it goes to the same database that the user subscribing in the app.
                //and once the user proceed back to the console, it will trigger a rerun of entire code in the messages stream,
                //because the user has subscribed to listen for the changes in the collection of messages.
                //as soon as there is change, it will print all the result again.
                //
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _authFireStore.collection('messages').add(
                        {
                          'text': message,
                          'sender': loggedInUser.email,
                        },
                      );
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //The function of the stream builder is to turn the snapshot of the data into actual widget when each time the new data come through.
    //so it is able to rebuild each time the new data coming through the stream, and it does that using set state.
    //in other word, set state will be called every time there is a new value in the stream.
    return StreamBuilder<QuerySnapshot>(
      // we add the the type which is the query snapshot to the stream builder, so that it will listen to the query snapshot.
      //
      //we are going to fetch these snapshot which is a stream. It is a stream of query snapshot,
      // the stream query snapshot is a class from the firebase which will ultimately contain all the chat messages.
      stream: _authFireStore.collection('messages').snapshots(),
      //our builder function has two inputs, which are the buildContext and async snapshot.
      // The async snapshot represent the most recent interaction with the stream, and our chat messages are buried in the async snapshot
      // and we can get access to it through the builder function.
      //
      //this snapshot is not same with the snapshot created in the messagestream() method above.
      // As the snapshot in the messagestream() method is firebase query snapshot, but currently used in the flutter async snapshot
      // as we are working with the stream builder.
      // The async snapshot actually consist the snapshot from the firebase.

      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        //this is how we can access the data inside the async snapshot.
        //However, we don't see the query snapshot data type,
        // but instead we see a dynamic data type.(click command q on the snapshot.data below.)
        // This is because, when we are building the stream builder, we don't tall what type of stream we will get.
        //when we tape on the snapshot above(command q). we can see it will return a stream of query snapshot,
        // and this is the data type that come from the cloud fire store, which represent all the data in our message collection.
        //
        // Once we tell what kind of data to the stream builder above(<QuerySnapshot>),
        // which mean now the data object get updated to the actual query snapshot.
        // and this also indicate we can start to call the document which is shown below. (snapshot.data.documents)
        //
        // In summary, the async snapshot contain the query snapshot from the firebase.
        // we access the query snapshot through the data property.
        // now we are dealing with the query snapshot object,
        // so we can use the query snapshot properties like the document property, which will eventually give us a list of document snapshot.
        //
        // From the summary above, we can say the async snapshot from the string builder contain the query snapshot from the firebase
        // The query snapshot in turn contain a list of document snapshot.
        final messages = snapshot.data.documents.reversed;
        // the snapshot is the sync snapshot from flutter.
        List<MessagesBubble> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          //the message is the document snapshot from firebase.
          final currentUser = loggedInUser.email;

          if (currentUser == messageSender) {
            //the message from the logged in user.
          }
          final messageBubble = MessagesBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          // Text('$messageText from $messageSender');
          messageWidgets.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: messageWidgets,
          ),
        );
        //here how it works is the user will send a new message to the firebase cloud fire store,
        // the moment the message hit the database, the user will get notified about the new message has come through
        // , and it gets added straight to the chat screen.
        // The reason it get added to the chat screen is because the screen builder receive the new async snapshot,
        // which will trigger the builder function, and rebuild the list of the text widgets in the screen.
        // so our code is reacting to the new event where the chat message being sent.
        //
      },
      // when the stream builder is interacting with the stream, and with each new event like a chat message being sent,
      // our string builder receives a snapshot, at this point the builder function will need to update the list of message displayed on the screen.
      // on other word, the builder need to rebuild all the children of the stream builder, which is the column of text widget
      //
    );
  }
}

class MessagesBubble extends StatelessWidget {
  MessagesBubble(
      {@required this.sender, @required this.text, @required this.isMe});
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black45,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 28.0),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.black45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
