import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/pages/message.dart';
import 'package:my_app_flutter/pages/searchPage.dart';

class ChatPage extends StatefulWidget {
  final String userId;// L'ID dell'utente destinatario
  final String name;
  ChatPage({required this.userId, required this.name});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class Message {
  final String senderId;
  final String message;

  Message({
    required this.senderId,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
    };
  }

  factory Message.fromMap(Map<dynamic, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      message: map['message'],
    );
  }
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  List<Message> _messages = [];
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  StreamController<void> _scrollToBottomStreamController = StreamController<void>();


  @override
  void dispose() {
    _scrollToBottomStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Qui puoi personalizzare la tua pagina di chat in base all'utente selezionato
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Chat con ${widget.name}'), // Mostra l'ID dell'utente nella barra dell'app
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _database.child('chats').child(_getChatId()).child('messages').onValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  });
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Errore: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                  return Text('Nessun messaggio disponibile.');
                } else {
                  final messagesMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  final List<Message> messages = [];

                  messagesMap.forEach((key, value) {
                    messages.add(Message.fromMap(value));
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: false, // Inverti l'ordine per far scorrere verso l'alto
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSentByCurrentUser = message.senderId == _auth.currentUser!.uid;
                      return  Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Align(
                          alignment: isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSentByCurrentUser ? Colors.blue : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(message.message),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Scrivi un messaggio...',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.pinkAccent.shade100,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    String messageText = _messageController.text;
                    if (messageText.isNotEmpty) {
                      String currentUserId = _auth.currentUser!.uid;
                      Message newMessage = Message(senderId: currentUserId, message: messageText);
                      await _database.child('chats').child(_getChatId()).child('messages').push().set(newMessage.toMap());
                      _messageController.clear();

                      // Dopo aver inviato un messaggio, scorri la schermata verso l'alto per visualizzare il nuovo messaggio
                      // _scrollController.jumpTo( 0);
                      // Scorrere automaticamente la schermata alla posizione massima per far apparire il nuovo messaggio
                      // double maxScrollExtent = _scrollController.position.maxScrollExtent;
                      // _scrollController.jumpTo(maxScrollExtent); // O _scrollController.animateTo(maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                      _scrollToBottomStreamController.add(null); // Aggiungi un valore all'evento per far scorrere verso il basso

                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getChatId() {
    String currentUserId = _auth.currentUser!.uid;
    List<String> userIds = [currentUserId, widget.userId];
    String receiverRoom = widget.userId + currentUserId;
    String messaggio = _messageController.text;
    if(!messaggio.isEmpty){
      Message newMessage = Message(senderId: currentUserId, message: messaggio);
      _database.child('chats').child(receiverRoom).child('messages').push().set(newMessage.toMap());
    }
    // userIds.sort(); // Ordina gli ID utente per ottenere un ID di chat univoco
    String chatId = userIds.join(); // Combina gli ID utente per ottenere l'ID della chat
    return chatId; // Restituisci il percorso completo all'ID della chat
  }
}

