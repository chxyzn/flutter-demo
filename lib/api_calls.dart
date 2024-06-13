import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<PokemonData>> getPokemon() async {
  final http.Response response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?=limit=20'));

  Map map = jsonDecode(response.body);

  List results = map['results'];
  List<PokemonData> resultList = [];

  results.forEach((element) {
    Map dummyMap = element as Map;
    PokemonData pokemonData = PokemonData.fromJson(dummyMap);
    resultList.add(pokemonData);
  });

  return resultList;
}

Future<Pokemon> getPokemonDetails(String url) async {
  final http.Response response = await http.get(Uri.parse(url));

  Map map = jsonDecode(response.body);

  Pokemon pokemon = Pokemon.fromJson(map);

  return pokemon;
}

class PokemonData {
  String name;
  String url;

  PokemonData({required this.name, required this.url});

  factory PokemonData.fromJson(Map json) {
    return PokemonData(name: json['name'], url: json['url']);
  }
}

class Pokemon {
  int weight;
  int height;
  int baseExp;

  Pokemon({required this.weight, required this.height, required this.baseExp});

  factory Pokemon.fromJson(Map json) {
    return Pokemon(
        weight: json['weight'],
        height: json['height'],
        baseExp: json['base_experience']);
  }
}
