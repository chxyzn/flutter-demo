import 'package:flutter/material.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final int weight, height, exp;
  const PokemonDetailsScreen(
      {super.key,
      required this.exp,
      required this.height,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        Center(
          child: Text(
            'Weight: $weight',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Center(
          child: Text(
            'Height: $height',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Center(
          child: Text(
            'Exp: $exp',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ]),
    );
  }
}
