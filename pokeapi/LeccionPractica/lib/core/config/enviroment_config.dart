/// Enum para definir diferentes entornos de la aplicación
enum Environment { development, staging, production }

/// Configuración específica por entorno
class EnvironmentConfig {
  static const Environment currentEnvironment = Environment.development;

  /// Configuración para diferentes entornos
  static const Map<Environment, Map<String, dynamic>> _config = {
    Environment.development: {
      'baseUrl':
      'https://pokeapi.co/api/v2/', // Actualiza con tu IP local
      'enableLogging': true,
      'connectionTimeout': 30,
      'receiveTimeout': 30,
    },
    Environment.staging: {
      'baseUrl': 'https://pokeapi.co/api/v2/',
      'enableLogging': true,
      'connectionTimeout': 30,
      'receiveTimeout': 30,
    },
    Environment.production: {
      'baseUrl': 'https://pokeapi.co/api/v2/',
      'enableLogging': false,
      'connectionTimeout': 15,
      'receiveTimeout': 15,
    },
  };

  /// Obtener configuración del entorno actual
  static Map<String, dynamic> get config => _config[currentEnvironment]!;

  /// Getters específicos para valores comunes
  static String get baseUrl => config['baseUrl'] as String;
  static bool get enableLogging => config['enableLogging'] as bool;
  static int get connectionTimeout => config['connectionTimeout'] as int;
  static int get receiveTimeout => config['receiveTimeout'] as int;

  /// Verificar si estamos en desarrollo
  static bool get isDevelopment =>
      currentEnvironment == Environment.development;
  static bool get isProduction => currentEnvironment == Environment.production;
}
