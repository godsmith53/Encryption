import 'package:encrypto/myEncryption.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class Encryption extends StatefulWidget {
  const Encryption({super.key});

  @override
  State<Encryption> createState() => _EncryptionState();
}

class _EncryptionState extends State<Encryption> {
  TextEditingController _textEditingController = TextEditingController();
  var encryptedText, plainText;
  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Encryption/Decryption"),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        width: ScreenWidth,
        height: ScreenHeight,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter Plain Text Here',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                plainText = _textEditingController.text;
                setState(() {
                  encryptedText = myEncryption.EncryptAES(plainText);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: ScreenWidth / 3,
                height: ScreenHeight / 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Encrypt",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(
              "Plain Text",
              style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(plainText == null ? "" : plainText),
            ),
            Text(
              "Encrypted Text",
              style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(encryptedText == null
                  ? ""
                  : encryptedText is encrypt.Encrypted
                      ? encryptedText.base64
                      : encryptedText),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  encryptedText = myEncryption.DecryptAES(encryptedText);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: ScreenWidth / 3,
                height: ScreenHeight / 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Decrypt",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
