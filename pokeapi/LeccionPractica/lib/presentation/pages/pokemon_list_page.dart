import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/pokemon_provider.dart';
import '../widgets/pokemon_card.dart';
import 'pokemon_detail_page.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PokemonProvider>(context, listen: false).fetchPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(child: Text('Error: ${provider.error}'))
              : ListView.builder(
                  itemCount: provider.pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = provider.pokemons[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PokemonDetailPage(pokemonId: pokemon.id),
                          ),
                        );
                      },
                      child: PokemonCard(id: pokemon.id, name: pokemon.name),// Ajusta el widget si es necesario
                    );
                  },
                ),
    );
  }
}