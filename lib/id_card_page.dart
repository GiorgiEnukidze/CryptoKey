import 'package:flutter/material.dart';
import 'package:flutter_kryptokey_1/add_id_card_page.dart';

class IdCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ID Cards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your ID Cards will be displayed here'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddIdCardPage()),
          );
        },
        tooltip: 'Add ID Card',
        child: Icon(Icons.add),
      ),
    );
  }
}
