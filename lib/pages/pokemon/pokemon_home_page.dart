import 'package:flutter/material.dart';
import 'package:guruh3/repositories/pokemon_repo.dart';

class PokemonHomePage extends StatelessWidget {
  const PokemonHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: FutureBuilder(
        future: PokemonRepo().getAllPokemons(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pokemon = snapshot.data![index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pokemon.name),
                      SizedBox(height: 20),
                      Row(
                        children: List.generate(
                          pokemon.type.length,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(pokemon.type[index]),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
