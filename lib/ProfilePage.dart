//this is a code for lab5.
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Repository.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late EncryptedSharedPreferences storedData;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    storedData = EncryptedSharedPreferences();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final firstName = await storedData.getString("firstName");
    final lastName = await storedData.getString("lastName");
    final phoneNumber = await storedData.getString("phoneNumber");
    final email = await storedData.getString("email");

    setState(() {
      _firstNameController.text = firstName;
      _lastNameController.text = lastName;
      _phoneNumberController.text = phoneNumber;
      _emailController.text = email;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    await storedData.setString("firstName", _firstNameController.text);
    await storedData.setString("lastName", _lastNameController.text);
    await storedData.setString("phoneNumber", _phoneNumberController.text);
    await storedData.setString("email", _emailController.text);
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showErrorDialog('URL not supported on this device');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                hintText: "First Name",
                border: OutlineInputBorder(),
                labelText: "First Name",
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                hintText: "Last Name",
                border: OutlineInputBorder(),
                labelText: "Last Name",
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      border: OutlineInputBorder(),
                      labelText: "Phone Number",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () => _launchURL('tel:${_phoneNumberController.text}'),
                ),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () => _launchURL('sms:${_phoneNumberController.text}'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.email),
                  onPressed: () => _launchURL('mailto:${_emailController.text}'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveData,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

