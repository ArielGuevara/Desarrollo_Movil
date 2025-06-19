import 'package:poke_api/domain/entities/pokemon_entity.dart';
import 'package:poke_api/domain/repositories/pokemon_repository.dart';
import 'package:poke_api/data/datasources/remote/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Pokemon>> getPokemons() {
    return remoteDataSource.getPokemons();
  }

  @override
  Future<Pokemon> getPokemonById(int pokemonId) {
    return remoteDataSource.getPokemonById(pokemonId);
  }
}