import 'package:flutter/material.dart';

class AddEncryptionKeyPage extends StatefulWidget {
  @override
  _AddEncryptionKeyPageState createState() => _AddEncryptionKeyPageState();
}

class _AddEncryptionKeyPageState extends State<AddEncryptionKeyPage> {
  final TextEditingController _keyNameController = TextEditingController();
  final TextEditingController _encryptionKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Encryption Key'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _keyNameController,
              decoration: InputDecoration(labelText: 'Key Name'),
            ),
            TextField(
              controller: _encryptionKeyController,
              decoration: InputDecoration(labelText: 'Encryption Key'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Add logic to save the encryption key
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
