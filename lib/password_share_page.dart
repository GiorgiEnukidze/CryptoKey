import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PasswordSharePage extends StatefulWidget {
  @override
  _PasswordSharePageState createState() => _PasswordSharePageState();
}

class _PasswordSharePageState extends State<PasswordSharePage> {
  TextEditingController userIdController = TextEditingController();
  String? selectedSite;
  DateTime? selectedDate;
  List<dynamic> sites = []; // Stocke les informations complètes des sites
  late String _token = ''; // Initialisation avec une valeur par défaut
  late FlutterSecureStorage _secureStorage = FlutterSecureStorage(); // Initialise _secureStorage

  late int _loggedInUserId = -1;
  late int _selectedPasswordEntryId = -1;

  @override
  void initState() {
    super.initState();
    _getTokenAndFetchUserSites();
    _fetchUserProfile();
  }

  Future<void> _getTokenAndFetchUserSites() async {
    await _getToken(); // Attendre la récupération du token
    fetchUserSites(); // Une fois le token récupéré, appelez fetchUserSites()
  }

  Future<void> _getToken() async {
    _token = await _secureStorage.read(key: 'auth_token') ?? ''; // Utiliser la même clé
    print('Token from storage: $_token'); // Vérifiez le token stocké
  }

  Future<void> fetchUserSites() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/passwords/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
      );

      print('Request header: ${response.request != null ? response.request!.headers : 'No request header available'}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        setState(() {
          sites = data;
        });
      } else {
        throw Exception('Failed to load user sites');
      }
    } catch (e) {
      print('Error fetching user sites: $e');
    }
  }

  Future<void> _fetchUserProfile() async {
    try {
      String? token = await _secureStorage.read(key: 'auth_token');
      if (token == null) {
        print('Auth token is null');
        return;
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/profile/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        setState(() {
          _loggedInUserId = userData.containsKey('id') ? userData['id'] : -1;
        });
      } else {
        print('Failed to load user profile');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> sharePassword() async {
    try {
      // Récupérer les données saisies par l'utilisateur
      int userId = int.parse(userIdController.text);
      if (selectedSite == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a site'),
          ),
        );
        return;
      }

      // Définir _selectedPasswordEntryId en fonction du site sélectionné
      final selectedSiteEntry = sites.firstWhere((site) => site['site_name'] == selectedSite);
      _selectedPasswordEntryId = selectedSiteEntry['id'];

      // Vérifier si l'utilisateur a sélectionné une date
      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a date'),
          ),
        );
        return;
      }

      // Afficher les données que l'utilisateur envoie
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ID of user to share: $userId\nSelected site: $selectedSite\nExpiration Date: $selectedDate'),
        ),
      );

      // Envoyer les données au backend avec le token d'authentification
      await sendPasswordShareData(userId, selectedSite!, selectedDate!);

    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> sendPasswordShareData(int userId, String site, DateTime expirationDate) async {
    try {
      String token = await _secureStorage.read(key: 'auth_token') ?? '';
      if (token.isEmpty) {
        print('Auth token is empty');
        return;
      }

      Map<String, dynamic> postData = {
        'shared_with_user_id': userId,
        'shared_by_user_id': _loggedInUserId,
        'password_entry_id': _selectedPasswordEntryId,
        'expiration_date': expirationDate.toIso8601String(),
      };

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/share/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 201) {
        print('Password shared successfully');
        // Traitez la réponse ici si nécessaire
      } else {
        print('Failed to share password');
        // Gérez les erreurs ici si nécessaire
      }

    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Passwords'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                labelText: 'ID of user to share',
              ),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              value: selectedSite,
              onChanged: (String? value) {
                setState(() {
                  selectedSite = value;
                });
              },
              items: sites.map<DropdownMenuItem<String>>((dynamic site) {
                return DropdownMenuItem<String>(
                  value: site['site_name'],
                  child: Text(site['site_name']),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Site to share',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: userIdController,
                    decoration: InputDecoration(
                      labelText: 'ID of user to share',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    selectedDate != null ? selectedDate.toString() : 'Select Date',
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: sharePassword,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
