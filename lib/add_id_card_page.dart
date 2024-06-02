import 'package:flutter/material.dart';
import 'package:flutter_kryptokey_1/encryption_service.dart';

class AddIdCardPage extends StatefulWidget {
  @override
  _AddIdCardPageState createState() => _AddIdCardPageState();
}

class _AddIdCardPageState extends State<AddIdCardPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nationalRegistryController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();

  final EncryptionService _encryptionService = EncryptionService();

  // Liste de tous les pays du monde avec leurs codes et drapeaux
  final List<Map<String, String?>> _countries = [
  {'name': 'Afghanistan', 'code': 'AF', 'flag': '🇦🇫'},
  {'name': 'Albania', 'code': 'AL', 'flag': '🇦🇱'},
  {'name': 'Algeria', 'code': 'DZ', 'flag': '🇩🇿'},
  {'name': 'Andorra', 'code': 'AD', 'flag': '🇦🇩'},
  {'name': 'Angola', 'code': 'AO', 'flag': '🇦🇴'},
  {'name': 'Antigua and Barbuda', 'code': 'AG', 'flag': '🇦🇬'},
  {'name': 'Argentina', 'code': 'AR', 'flag': '🇦🇷'},
  {'name': 'Armenia', 'code': 'AM', 'flag': '🇦🇲'},
  {'name': 'Australia', 'code': 'AU', 'flag': '🇦🇺'},
  {'name': 'Austria', 'code': 'AT', 'flag': '🇦🇹'},
  {'name': 'Azerbaijan', 'code': 'AZ', 'flag': '🇦🇿'},
  {'name': 'Bahamas', 'code': 'BS', 'flag': '🇧🇸'},
  {'name': 'Bahrain', 'code': 'BH', 'flag': '🇧🇭'},
  {'name': 'Bangladesh', 'code': 'BD', 'flag': '🇧🇩'},
  {'name': 'Barbados', 'code': 'BB', 'flag': '🇧🇧'},
  {'name': 'Belarus', 'code': 'BY', 'flag': '🇧🇾'},
  {'name': 'Belgium', 'code': 'BE', 'flag': '🇧🇪'},
  {'name': 'Belize', 'code': 'BZ', 'flag': '🇧🇿'},
  {'name': 'Benin', 'code': 'BJ', 'flag': '🇧🇯'},
  {'name': 'Bhutan', 'code': 'BT', 'flag': '🇧🇹'},
  {'name': 'Bolivia', 'code': 'BO', 'flag': '🇧🇴'},
  {'name': 'Bosnia and Herzegovina', 'code': 'BA', 'flag': '🇧🇦'},
  {'name': 'Botswana', 'code': 'BW', 'flag': '🇧🇼'},
  {'name': 'Brazil', 'code': 'BR', 'flag': '🇧🇷'},
  {'name': 'Brunei', 'code': 'BN', 'flag': '🇧🇳'},
  {'name': 'Bulgaria', 'code': 'BG', 'flag': '🇧🇬'},
  {'name': 'Burkina Faso', 'code': 'BF', 'flag': '🇧🇫'},
  {'name': 'Burundi', 'code': 'BI', 'flag': '🇧🇮'},
  {'name': 'Cabo Verde', 'code': 'CV', 'flag': '🇨🇻'},
  {'name': 'Cambodia', 'code': 'KH', 'flag': '🇰🇭'},
  {'name': 'Cameroon', 'code': 'CM', 'flag': '🇨🇲'},
  {'name': 'Canada', 'code': 'CA', 'flag': '🇨🇦'},
  {'name': 'Central African Republic', 'code': 'CF', 'flag': '🇨🇫'},
  {'name': 'Chad', 'code': 'TD', 'flag': '🇹🇩'},
  {'name': 'Chile', 'code': 'CL', 'flag': '🇨🇱'},
  {'name': 'China', 'code': 'CN', 'flag': '🇨🇳'},
  {'name': 'Colombia', 'code': 'CO', 'flag': '🇨🇴'},
  {'name': 'Comoros', 'code': 'KM', 'flag': '🇰🇲'},
  {'name': 'Congo (Congo-Brazzaville)', 'code': 'CG', 'flag': '🇨🇬'},
  {'name': 'Costa Rica', 'code': 'CR', 'flag': '🇨🇷'},
  {'name': 'Croatia', 'code': 'HR', 'flag': '🇭🇷'},
  {'name': 'Cuba', 'code': 'CU', 'flag': '🇨🇺'},
  {'name': 'Cyprus', 'code': 'CY', 'flag': '🇨🇾'},
  {'name': 'Czechia (Czech Republic)', 'code': 'CZ', 'flag': '🇨🇿'},
  {'name': 'Democratic Republic of the Congo', 'code': 'CD', 'flag': '🇨🇩'},
  {'name': 'Denmark', 'code': 'DK', 'flag': '🇩🇰'},
  {'name': 'Djibouti', 'code': 'DJ', 'flag': '🇩🇯'},
  {'name': 'Dominica', 'code': 'DM', 'flag': '🇩🇲'},
  {'name': 'Dominican Republic', 'code': 'DO', 'flag': '🇩🇴'},
  {'name': 'Ecuador', 'code': 'EC', 'flag': '🇪🇨'},
  {'name': 'Egypt', 'code': 'EG', 'flag': '🇪🇬'},
  {'name': 'El Salvador', 'code': 'SV', 'flag': '🇸🇻'},
  {'name': 'Equatorial Guinea', 'code': 'GQ', 'flag': '\ud83c\udde9\ud83c\uddea'},
  {'name': 'Eritrea', 'code': 'ER', 'flag': '\ud83c\uddea\ud83c\uddf7'},
  {'name': 'Estonia', 'code': 'EE', 'flag': '\ud83c\uddea\ud83c\uddea'},
  {'name': 'Eswatini (fmr. "Swaziland")', 'code': 'SZ', 'flag': '\ud83c\uddea\ud83c\uddff'},
  {'name': 'Ethiopia', 'code': 'ET', 'flag': '\ud83c\uddea\ud83c\uddf9'},
  {'name': 'Fiji', 'code': 'FJ', 'flag': '\ud83c\uddeb\ud83c\uddef'},
  {'name': 'Finland', 'code': 'FI', 'flag': '\ud83c\uddea\ud83c\uddee'},
  {'name': 'France', 'code': 'FR', 'flag': '\ud83c\uddeb\ud83c\uddf7'},
  {'name': 'Gabon', 'code': 'GA', 'flag': '\ud83c\uddec\ud83c\udde6'},
  {'name': 'Gambia', 'code': 'GM', 'flag': '\ud83c\uddec\ud83c\uddf2'},
  {'name': 'Georgia', 'code': 'GE', 'flag': '\ud83c\uddec\ud83c\uddea'},
  {'name': 'Germany', 'code': 'DE', 'flag': '\ud83c\udde9\ud83c\uddea'},
  {'name': 'Ghana', 'code': 'GH', 'flag': '\ud83c\uddec\ud83c\uddd6'},
  {'name': 'Greece', 'code': 'GR', 'flag': '\ud83c\uddec\ud83c\uddf7'},
  {'name': 'Grenada', 'code': 'GD', 'flag': '\ud83c\uddec\ud83c\udde9'},
  {'name': 'Guatemala', 'code': 'GT', 'flag': '\ud83c\uddec\ud83c\uddf9'},
  {'name': 'Guinea', 'code': 'GN', 'flag': '\ud83c\uddec\ud83c\uddf3'},
  {'name': 'Guinea-Bissau', 'code': 'GW', 'flag': '\ud83c\uddec\ud83c\uddfc'},
  {'name': 'Guyana', 'code': 'GY', 'flag': '\ud83c\uddec\ud83c\uddfe'},
  {'name': 'Haiti', 'code': 'HT', 'flag': '\ud83c\uddf9\ud83c\uddf9'},
  {'name': 'Holy See', 'code': 'VA', 'flag': '\ud83c\uddfa\ud83c\uddfe'},
  {'name': 'Honduras', 'code': 'HN', 'flag': '\ud83c\udded\ud83c\uddf3'},
  {'name': 'Hungary', 'code': 'HU', 'flag': '\ud83c\udded\ud83c\uddfa'},
  {'name': 'Iceland', 'code': 'IS', 'flag': '\ud83c\uddee\ud83c\uddf8'},
  {'name': 'India', 'code': 'IN', 'flag': '\ud83c\uddee\ud83c\uddf3'},
  {'name': 'Indonesia', 'code': 'ID', 'flag': '\ud83c\uddee\ud83c\uddee'},
  {'name': 'Iran', 'code': 'IR', 'flag': '\ud83c\uddee\ud83c\uddf7'},
  {'name': 'Iraq', 'code': 'IQ', 'flag': '\ud83c\uddee\ud83c\uddf6'},
  {'name': 'Ireland', 'code': 'IE', 'flag': '\ud83c\uddee\ud83c\uddea'},
  {'name': 'Israel', 'code': 'IL', 'flag': '\ud83c\uddee\ud83c\uddf1'},
  {'name': 'Italy', 'code': 'IT', 'flag': '\ud83c\uddee\ud83c\uddf9'},
  {'name': 'Jamaica', 'code': 'JM', 'flag': '\ud83c\uddef\ud83c\uddf2'},
  {'name': 'Japan', 'code': 'JP', 'flag': '\ud83c\uddef\ud83c\uddf5'},
  {'name': 'Jordan', 'code': 'JO', 'flag': '🇯🇴'},
{'name': 'Kazakhstan', 'code': 'KZ', 'flag': '🇰🇿'},
{'name': 'Kenya', 'code': 'KE', 'flag': '🇰🇪'},
{'name': 'Kiribati', 'code': 'KI', 'flag': '🇰🇮'},
{'name': 'Kuwait', 'code': 'KW', 'flag': '🇰🇼'},
{'name': 'Kyrgyzstan', 'code': 'KG', 'flag': '🇰🇬'},
{'name': 'Laos', 'code': 'LA', 'flag': '🇱🇦'},
{'name': 'Latvia', 'code': 'LV', 'flag': '🇱🇻'},
{'name': 'Lebanon', 'code': 'LB', 'flag': '🇱🇧'},
{'name': 'Lesotho', 'code': 'LS', 'flag': '🇱🇸'},
{'name': 'Liberia', 'code': 'LR', 'flag': '🇱🇷'},
{'name': 'Libya', 'code': 'LY', 'flag': '🇱🇾'},
{'name': 'Liechtenstein', 'code': 'LI', 'flag': '🇱🇮'},
{'name': 'Lithuania', 'code': 'LT', 'flag': '🇱🇹'},
{'name': 'Luxembourg', 'code': 'LU', 'flag': '🇱🇺'},
{'name': 'Madagascar', 'code': 'MG', 'flag': '🇲🇬'},
{'name': 'Malawi', 'code': 'MW', 'flag': '🇲🇼'},
{'name': 'Malaysia', 'code': 'MY', 'flag': '🇲🇾'},
{'name': 'Maldives', 'code': 'MV', 'flag': '🇲🇻'},
{'name': 'Mali', 'code': 'ML', 'flag': '🇲🇱'},
{'name': 'Malta', 'code': 'MT', 'flag': '🇲🇹'},
{'name': 'Marshall Islands', 'code': 'MH', 'flag': '🇲🇭'},
{'name': 'Mauritania', 'code': 'MR', 'flag': '🇲🇷'},
{'name': 'Mauritius', 'code': 'MU', 'flag': '🇲🇺'},
{'name': 'Mexico', 'code': 'MX', 'flag': '🇲🇽'},
{'name': 'Micronesia', 'code': 'FM', 'flag': '🇫🇲'},
{'name': 'Moldova', 'code': 'MD', 'flag': '🇲🇩'},
{'name': 'Monaco', 'code': 'MC', 'flag': '🇲🇨'},
{'name': 'Mongolia', 'code': 'MN', 'flag': '🇲🇳'},
{'name': 'Montenegro', 'code': 'ME', 'flag': '🇲🇪'},
{'name': 'Morocco', 'code': 'MA', 'flag': '🇲🇦'},
{'name': 'Mozambique', 'code': 'MZ', 'flag': '🇲🇿'},
{'name': 'Myanmar (formerly Burma)', 'code': 'MM', 'flag': '🇲🇲'},
{'name': 'Namibia', 'code': 'NA', 'flag': '🇳🇦'},
{'name': 'Nauru', 'code': 'NR', 'flag': '🇳🇷'},
{'name': 'Nepal', 'code': 'NP', 'flag': '🇳🇵'},
{'name': 'Netherlands', 'code': 'NL', 'flag': '🇳🇱'},
{'name': 'New Zealand', 'code': 'NZ', 'flag': '🇳🇿'},
{'name': 'Nicaragua', 'code': 'NI', 'flag': '🇳🇮'},
{'name': 'Niger', 'code': 'NE', 'flag': '🇳🇪'},
{'name': 'Nigeria', 'code': 'NG', 'flag': '🇳🇬'},
{'name': 'North Korea', 'code': 'KP', 'flag': '🇰🇵'},
{'name': 'North Macedonia', 'code': 'MK', 'flag': '🇲🇰'},
{'name': 'Norway', 'code': 'NO', 'flag': '🇳🇴'},
{'name': 'Oman', 'code': 'OM', 'flag': '🇴🇲'},
{'name': 'Pakistan', 'code': 'PK', 'flag': '🇵🇰'},
{'name': 'Palau', 'code': 'PW', 'flag': '🇵🇼'},
{'name': 'Palestine State', 'code': 'PS', 'flag': '🇵🇸'},
{'name': 'Panama', 'code': 'PA', 'flag': '🇵🇦'},
{'name': 'Papua New Guinea', 'code': 'PG', 'flag': '🇵🇬'},
{'name': 'Paraguay', 'code': 'PY', 'flag': '🇵🇾'},
{'name': 'Peru', 'code': 'PE', 'flag': '🇵🇪'},
{'name': 'Philippines', 'code': 'PH', 'flag': '🇵🇭'},
{'name': 'Poland', 'code': 'PL', 'flag': '🇵🇱'},
{'name': 'Portugal', 'code': 'PT', 'flag': '🇵🇹'},
{'name': 'Qatar', 'code': 'QA', 'flag': '🇶🇦'},
{'name': 'Romania', 'code': 'RO', 'flag': '🇷🇴'},
{'name': 'Russia', 'code': 'RU', 'flag': '🇷🇺'},
{'name': 'Rwanda', 'code': 'RW', 'flag': '🇷🇼'},
{'name': 'Saint Kitts and Nevis', 'code': 'KN', 'flag': '🇰🇳'},
{'name': 'Saint Lucia', 'code': 'LC', 'flag': '🇱🇨'},
{'name': 'Saint Vincent and the Grenadines', 'code': 'VC', 'flag': '🇻🇨'},
{'name': 'Samoa', 'code': 'WS', 'flag': '🇼🇸'},
{'name': 'San Marino', 'code': 'SM', 'flag': '🇸🇲'},
{'name': 'Sao Tome and Principe', 'code': 'ST', 'flag': '🇸🇹'},
{'name': 'Saudi Arabia', 'code': 'SA', 'flag': '🇸🇦'},
{'name': 'Senegal', 'code': 'SN', 'flag': '🇸🇳'},
{'name': 'Serbia', 'code': 'RS', 'flag': '🇷🇸'},
{'name': 'Seychelles', 'code': 'SC', 'flag': '🇸🇨'},
{'name': 'Sierra Leone', 'code': 'SL', 'flag': '🇸🇱'},
{'name': 'Singapore', 'code': 'SG', 'flag': '🇸🇬'},
{'name': 'Slovakia', 'code': 'SK', 'flag': '🇸🇰'},
{'name': 'Slovenia', 'code': 'SI', 'flag': '🇸🇮'},
{'name': 'Solomon Islands', 'code': 'SB', 'flag': '🇸🇧'},
{'name': 'Somalia', 'code': 'SO', 'flag': '🇸🇴'},
{'name': 'South Africa', 'code': 'ZA', 'flag': '🇿🇦'},
{'name': 'South Korea', 'code': 'KR', 'flag': '🇰🇷'},
{'name': 'South Sudan', 'code': 'SS', 'flag': '🇸🇸'},
{'name': 'Spain', 'code': 'ES', 'flag': '🇪🇸'},
{'name': 'Sri Lanka', 'code': 'LK', 'flag': '🇱🇰'},
{'name': 'Sudan', 'code': 'SD', 'flag': '🇸🇩'},
{'name': 'Suriname', 'code': 'SR', 'flag': '🇸🇷'},
{'name': 'Sweden', 'code': 'SE', 'flag': '🇸🇪'},
{'name': 'Switzerland', 'code': 'CH', 'flag': '🇨🇭'},
{'name': 'Syria', 'code': 'SY', 'flag': '🇸🇾'},
{'name': 'Tajikistan', 'code': 'TJ', 'flag': '🇹🇯'},
{'name': 'Tanzania', 'code': 'TZ', 'flag': '🇹🇿'},
{'name': 'Thailand', 'code': 'TH', 'flag': '🇹🇭'},
{'name': 'Timor-Leste', 'code': 'TL', 'flag': '🇹🇱'},
{'name': 'Togo', 'code': 'TG', 'flag': '🇹🇬'},
{'name': 'Tonga', 'code': 'TO', 'flag': '🇹🇴'},
{'name': 'Trinidad and Tobago', 'code': 'TT', 'flag': '🇹🇹'},
{'name': 'Tunisia', 'code': 'TN', 'flag': '🇹🇳'},
{'name': 'Turkey', 'code': 'TR', 'flag': '🇹🇷'},
{'name': 'Turkmenistan', 'code': 'TM', 'flag': '🇹🇲'},
{'name': 'Tuvalu', 'code': 'TV', 'flag': '🇹🇻'},
{'name': 'Uganda', 'code': 'UG', 'flag': '🇺🇬'},
{'name': 'Ukraine', 'code': 'UA', 'flag': '🇺🇦'},
{'name': 'United Arab Emirates', 'code': 'AE', 'flag': '🇦🇪'},
{'name': 'United Kingdom', 'code': 'GB', 'flag': '🇬🇧'},
{'name': 'United States of America', 'code': 'US', 'flag': '🇺🇸'},
{'name': 'Uruguay', 'code': 'UY', 'flag': '🇺🇾'},
{'name': 'Uzbekistan', 'code': 'UZ', 'flag': '🇺🇿'},
{'name':'Vanuatu', 'code': 'VU', 'flag': '🇻🇺'},
{'name': 'Vatican City', 'code': 'VA', 'flag': '🇻🇦'},
{'name': 'Venezuela', 'code': 'VE', 'flag': '🇻🇪'},
{'name': 'Vietnam', 'code': 'VN', 'flag': '🇻🇳'},
{'name': 'Yemen', 'code': 'YE', 'flag': '🇾🇪'},
{'name': 'Zambia', 'code': 'ZM', 'flag': '🇿🇲'},
{'name': 'Zimbabwe', 'code': 'ZW', 'flag': '🇿🇼'},

  ];

  String _selectedCountry = ''; // Pays sélectionné

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ID Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _nationalRegistryController,
              decoration: InputDecoration(labelText: 'National Registry (ex: 02.08.02-389.66)'),
            ),
            TextField(
              controller: _expiryDateController,
              decoration: InputDecoration(labelText: 'Expiry Date (ex: 28 03 2034)'),
            ),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(labelText: 'Card Number (ex: 595-2164728-94)'),
            ),
            // Menu déroulant pour la nationalité
            DropdownButtonFormField(
              value: _selectedCountry.isNotEmpty ? _selectedCountry : null,
              onChanged: (String? value) {
                setState(() {
                  _selectedCountry = value!;
                  _nationalityController.text = value;
                });
              },
              items: _countries
                  .map<DropdownMenuItem<String>>(
                    (country) => DropdownMenuItem<String>(
                      value: country['code']!,
                      child: Row(
                        children: [
                          Text(country['flag'] ?? '', style: TextStyle(fontSize: 20)),
                          SizedBox(width: 8),
                          Text('${country['name']} (${country['code']})'),
                        ],
                      ),
                    ),
                  )
                  .toList()
                    ..sort((a, b) => (a.child as Row).children[1].toString().compareTo((b.child as Row).children[1].toString())),
              decoration: InputDecoration(labelText: 'Nationality'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Encrypt and store the ID card information
                await _encryptionService.storeEncryptedData('first_name', _firstNameController.text);
                await _encryptionService.storeEncryptedData('last_name', _lastNameController.text);
                await _encryptionService.storeEncryptedData('national_registry', _nationalRegistryController.text);
                await _encryptionService.storeEncryptedData('expiry_date', _expiryDateController.text);
                await _encryptionService.storeEncryptedData('card_number', _cardNumberController.text);
                await _encryptionService.storeEncryptedData('nationality', _nationalityController.text);
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
