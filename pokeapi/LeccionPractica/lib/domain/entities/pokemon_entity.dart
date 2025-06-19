import 'package:poke_api/domain/entities/pokemon_entity.dart';

class Pokemon {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final int weight;
  final int order;
  final Map<String, int> stats;
  final List<String> abilities;
  final List<String> moves;

  Pokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.order,
    required this.stats,
    required this.abilities,
    required this.moves,
  });


  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // Extraer habilidades
    List<String> abilities = (json['abilities'] as List)
        .map((ability) => ability['ability']['name'] as String)
        .toList();

    // Extraer movimientos
    List<String> moves = (json['moves'] as List)
        .map((move) => move['move']['name'] as String)
        .toList();

    return Pokemon(
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      order: json['order'],
      stats: {}, // Por ahora vacío
      abilities: abilities,
      moves: moves,
    );
  }
}

