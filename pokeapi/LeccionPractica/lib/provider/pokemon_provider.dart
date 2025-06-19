// lib/provider/pokemon_provider.dart
import 'package:flutter/material.dart';
import '../domain/entities/pokemon_entity.dart';
import '../data/repositories/pokemon_repository.dart';

class PokemonProvider extends ChangeNotifier {
  final PokemonRepositoryImpl repository;

  List<Pokemon> pokemons = [];
  bool isLoading = false;
  String? error;

  PokemonProvider({required this.repository});

  Future<void> fetchPokemons() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      pokemons = await repository.getPokemons();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}