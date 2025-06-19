import 'package:poke_api/domain/entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons();
  Future<Pokemon> getPokemonById(int pokemonId);
}