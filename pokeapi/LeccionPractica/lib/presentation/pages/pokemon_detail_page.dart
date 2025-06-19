import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import '../../provider/pokemon_provider.dart';
  import '../../domain/entities/pokemon_entity.dart';

  class PokemonDetailPage extends StatelessWidget {
    final int pokemonId;

    const PokemonDetailPage({super.key, required this.pokemonId});

    Future<Pokemon> _fetchDetail(BuildContext context) {
      final provider = Provider.of<PokemonProvider>(context, listen: false);
      return provider.repository.getPokemonById(pokemonId);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalles del Pokémon'),
          backgroundColor: Colors.deepPurple,
        ),
        body: FutureBuilder<Pokemon>(
          future: _fetchDetail(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No se encontraron datos'));
            }
            final detail = snapshot.data!;
            final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${detail.id}.png';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image.network(
                            imageUrl,
                            width: 120,
                            height: 120,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 80),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            detail.name[0].toUpperCase() + detail.name.substring(1),
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Chip(
                                avatar: const Icon(Icons.height, size: 18),
                                label: Text('Altura: ${detail.height}'),
                              ),
                              const SizedBox(width: 12),
                              Chip(
                                avatar: const Icon(Icons.monitor_weight, size: 18),
                                label: Text('Peso: ${detail.weight}'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Habilidades',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.deepPurple[700]),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 8,
                            children: detail.abilities
                                .map((a) => Chip(
                                      label: Text(a),
                                      backgroundColor: Colors.deepPurple[50],
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Movimientos',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.deepPurple[700]),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: detail.moves.take(8).map((m) => Chip(label: Text(m))).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }