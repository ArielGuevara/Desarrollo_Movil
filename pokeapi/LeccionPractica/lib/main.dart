import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'presentation/pages/pokemon_list_page.dart';
import 'provider/pokemon_provider.dart';
import 'data/datasources/remote/pokemon_remote_data_source.dart';
import 'data/repositories/pokemon_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonProvider(
            repository: PokemonRepositoryImpl(
              remoteDataSource: PokemonRemoteDataSourceImpl(
                client: http.Client(),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Pokédex',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const PokemonListPage(),
      ),
    );
  }
}