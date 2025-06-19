// lib/data/datasources/remote/pokemon_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poke_api/domain/entities/pokemon_entity.dart';
import 'package:poke_api/core/config/app_config.dart';

abstract class PokemonRemoteDataSource {
  Future<List<Pokemon>> getPokemons();
  Future<Pokemon> getPokemonById(int pokemonId);
}
// lib/data/datasources/remote/pokemon_remote_data_source.dart
class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Pokemon>> getPokemons() async {
    final response = await client.get(Uri.parse(AppConfig.ordersUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      // Debes hacer una petición por cada Pokémon para obtener sus detalles completos
      // Aquí solo se obtiene el nombre y url, puedes ajustar según tu necesidad
      return Future.wait(results.map((item) async {
        final detailResponse = await client.get(Uri.parse(item['url']));
        if (detailResponse.statusCode == 200) {
          return Pokemon.fromJson(json.decode(detailResponse.body));
        } else {
          throw Exception('Failed to load pokemon details');
        }
      }));
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  @override
  Future<Pokemon> getPokemonById(int pokemonId) async {
    final response = await client.get(
      Uri.parse('${AppConfig.ordersUrl}/$pokemonId'),
    );
    if (response.statusCode == 200) {
      return Pokemon.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
}