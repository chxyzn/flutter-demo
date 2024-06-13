import 'package:flutter/material.dart';
import 'package:flutter_app/api_calls.dart';
import 'package:flutter_app/api_calls_login.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/phonepe.dart';
import 'package:flutter_app/pokemon_details.dart';
import 'package:flutter_app/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? isLoggedIn = await EncryptedStorage().read('isLoggedIn');

  if (isLoggedIn == null) {
    runApp(const LoginScreenWrapper());
  }

  runApp(const MyApp());
}

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
  List<PokemonData> filteredList = [];
  List<PokemonData> allPokemon = [];

  int currentIndex = 0;

  void filterPokemon(String query, List<PokemonData> allPokemon) {
    List<PokemonData> filterList = [];

    for (var element in allPokemon) {
      if (element.name.startsWith(query)) {
        filterList.add(element);
      }
    }

    setState(() {
      filteredList = filterList;
    });
  }

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
      body: (currentIndex == 1)
          ? PhonePeScreen()
          : (currentIndex == 2)
              ? ProfileScreen()
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: searchBoxController,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Search'),
                          onChanged: (input) {
                            filterPokemon(input, allPokemon);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder(
                          future: getPokemon(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              allPokemon = snapshot.data ?? [];

                              return SizedBox(
                                height: 600,
                                width: 200,
                                child: ListView.builder(
                                  itemCount: filteredList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        Pokemon pokemon =
                                            await getPokemonDetails(
                                                filteredList[index].url ?? '');

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return PokemonDetailsScreen(
                                            exp: pokemon.baseExp,
                                            height: pokemon.height,
                                            weight: pokemon.weight,
                                          );
                                        }));

                                        print(pokemon.height);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 60,
                                          width: 40,
                                          color: Colors.blue,
                                          child: Center(
                                              child: Text(
                                                  '${filteredList[index].name}')),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
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
