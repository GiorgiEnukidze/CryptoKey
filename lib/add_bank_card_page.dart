import 'package:flutter/material.dart';
import 'package:flutter_kryptokey_1/encryption_service.dart';

class AddBankCardPage extends StatefulWidget {
  @override
  _AddBankCardPageState createState() => _AddBankCardPageState();
}

class _AddBankCardPageState extends State<AddBankCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  final EncryptionService _encryptionService = EncryptionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bank Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            TextField(
              controller: _cardNameController,
              decoration: InputDecoration(labelText: 'Name on Card'),
            ),
            TextField(
              controller: _expiryDateController,
              decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
            ),
            TextField(
              controller: _cvcController,
              decoration: InputDecoration(labelText: 'CVC'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Encrypt and store the bank card information
                await _encryptionService.storeEncryptedData('card_number', _cardNumberController.text);
                await _encryptionService.storeEncryptedData('card_name', _cardNameController.text);
                await _encryptionService.storeEncryptedData('expiry_date', _expiryDateController.text);
                await _encryptionService.storeEncryptedData('cvc', _cvcController.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
