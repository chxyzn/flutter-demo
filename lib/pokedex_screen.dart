import 'package:flutter/material.dart';
import 'package:flutter_app/api_calls.dart';
import 'package:flutter_app/pokemon_details.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  TextEditingController searchBoxController = TextEditingController();
  String serachInput = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: TextField(
              controller: searchBoxController,
              decoration: const InputDecoration.collapsed(hintText: 'Search'),
              onChanged: (input) {
                setState(() {
                  serachInput = input;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder(
              future: getPokemon(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return SizedBox(
                    height: 400,
                    width: 200,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data![index].name.contains(serachInput)) {
                          return GestureDetector(
                            
                            onTap: () async {
                              Pokemon pokemon = await getPokemonDetails(
                                  snapshot.data![index].url);

                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PokemonDetailsScreen(
                                  exp: pokemon.baseExp,
                                  height: pokemon.height,
                                  weight: pokemon.weight,
                                );
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                width: 40,
                                color: Colors.blue,
                                child: Center(
                                    child:
                                        Text('${snapshot.data![index].name}')),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
