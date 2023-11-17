import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  final String encryptionKey = 'YourEncryptionKey';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String messageText) {
    // Encrypt the message
    final key = encrypt.Key.fromUtf8(encryptionKey);
    final iv = encrypt.IV.fromLength(16);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

    final encryptedMessage = encrypter.encrypt(messageText, iv: iv);

    // In a real app, you would send the encrypted message to the recipient.
    // Here, we simulate receiving the message.
    receiveMessage(encryptedMessage.base64);
  }

  void receiveMessage(String encryptedMessageBase64) {
    // Decrypt the received message
    final key = encrypt.Key.fromUtf8(encryptionKey);
    final iv = encrypt.IV.fromLength(16);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

    final encryptedMessage =
        encrypt.Encrypted.fromBase64(encryptedMessageBase64);
    final decryptedMessage = encrypter.decrypt(encryptedMessage, iv: iv);

    // Display the decrypted message
    setState(() {
      messages.add(decryptedMessage);
      messageController.clear();
    });
  }
}
