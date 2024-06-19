import 'package:flutter/material.dart';
import 'Repository.dart';
import 'ProfilePage.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/profile': (context) => ProfilePage(),
        '/myHomePage': (context) => MyHomePage(title: 'Flutter Demo')
      },
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  late TextEditingController _controller1;
  String imageSource = "images/question-mark.png"; // Default image source
  late EncryptedSharedPreferences storedData;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller1 = TextEditingController();
    storedData = EncryptedSharedPreferences();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final savedUsername = await storedData.getString("username");
    final savedPassword = await storedData.getString("password");

    if (savedUsername != null && savedPassword != null) {
      _controller.text = savedUsername;
      _controller1.text = savedPassword;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Previous login name and password loaded'),
          action: SnackBarAction(
            label: 'Clear Saved Data',
            onPressed: () {
              storedData.remove("username");
              storedData.remove("password");
              _controller.text = "";
              _controller1.text = "";
            },
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    super.dispose();
  }

  void buttonClicked() {
    String password = _controller1.text.trim();
    if (password == "QWERTY123") {
      setState(() {
        imageSource = "images/idea.png"; // Change image to light bulb
      });
      Navigator.pushNamed(context, '/profile');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome Back ${_controller.text}')),
      );
    } else {
      setState(() {
        imageSource = "images/stop.png"; // Change image to stop sign
      });
    }
    _showSaveDialog();
  }

  void _showSaveDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Save Credentials'),
        content: const Text(
            'Would you like to save your username and password for the next time?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _saveCredentials();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              storedData.remove("username");
              storedData.remove("password");
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveCredentials() async {
    await storedData.setString("username", _controller.text);
    await storedData.setString("password", _controller1.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type here",
                border: OutlineInputBorder(),
                labelText: "Login",
              ),
              obscureText: false,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller1,
              decoration: InputDecoration(
                hintText: "Type here",
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: buttonClicked,
              child: Text("Login"),
            ),
            Image.asset(
              imageSource,
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}


