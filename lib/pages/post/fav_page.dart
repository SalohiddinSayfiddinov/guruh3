import 'package:flutter/material.dart';
import 'package:guruh3/provider/favourites_provider.dart';
import 'package:provider/provider.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<FavouritesProvider>().favourites;

    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]['name'].toString()),
            trailing: IconButton(
              onPressed: () {
                products.remove(products[index]);
              },
              icon: Icon(Icons.favorite),
            ),
          );
        },
      ),
    );
  }
}
