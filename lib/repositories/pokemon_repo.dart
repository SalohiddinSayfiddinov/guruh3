import 'dart:convert';

import 'package:guruh3/models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRepo {
  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"),
      );
      List data = jsonDecode(response.body)['pokemon'];
      final pokemons = data.map((json) => Pokemon.fromJson(json)).toList();
      return pokemons;
    } catch (e, s) {
      print(s);
      throw Exception(e.toString());
    }
  }
}
