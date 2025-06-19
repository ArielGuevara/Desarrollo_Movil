// lib/presentation/widgets/pokemon_card.dart
    import 'package:flutter/material.dart';

    class PokemonCard extends StatelessWidget {
      final int id;
      final String name;

      const PokemonCard({super.key, required this.id, required this.name});

      @override
      Widget build(BuildContext context) {
        final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
        return Card(
          child: ListTile(
            leading: Image.network(
              imageUrl,
              width: 56,
              height: 56,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
            title: Text(name),
          ),
        );
      }
    }