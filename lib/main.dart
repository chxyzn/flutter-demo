import 'package:flutter/material.dart';
import 'package:flutter_app/api_calls.dart';
import 'package:flutter_app/api_calls_login.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/phonepe.dart';
import 'package:flutter_app/pokedex_screen.dart';
import 'package:flutter_app/pokemon_details.dart';
import 'package:flutter_app/profile_screen.dart';

String? profilePicturePath;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? isLoggedIn = await EncryptedStorage().read('isLoggedIn');
  profilePicturePath = await EncryptedStorage().read('image');

  if (isLoggedIn == null) {
    runApp(const LoginScreenWrapper());
  }

  runApp(const MyApp());
}

List<Widget> widgetOptions = [
  const PokedexScreen(),
  const PhonePeScreen(),
  const ProfileScreen(),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchBoxController = TextEditingController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          GestureDetector(
            onTap: () async {
              await EncryptedStorage().clear();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }));
            },
            child: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: widgetOptions[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.abc_outlined), label: 'Pokedex'),
          BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'PhonePe'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
