/// La classe `ServerConfigs` contient des configurations statiques pour 
/// la communication avec le serveur backend. Elle centralise les informations 
/// nécessaires pour effectuer des requêtes API depuis l'application.
///
/// Attributs:
///
/// - `base_url`: L'URL de base du serveur backend.
///
/// - `api_get_departure_time_arrival_url`: URL complète pour accéder à l'API 
///   permettant de récupérer les horaires de trajet entre les villes de départ et d'arrivée. Elle est 
///   construite en ajoutant "/routes/route/time" à l'URL de base.
///
/// - `bearer_token`: Jeton d'authentification (Bearer token) utilisé pour 
///   sécuriser les requêtes API. 
///
/// Cette classe permet de centraliser les configurations du serveur, ce qui 
/// facilite la maintenance et la gestion des URLs et des informations 
/// d'authentification dans l'application.
/// 
class ServerConfigs {
  static String base_url = "http://194.57.103.203:8000";
  static String api_get_departure_time_arrival_url =
      "$base_url/routes/route/time";
  static String bearer_token =
      r"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcyNDU0NDQxNCwianRpIjoiYzBiYjBjOTEtNDBkOS00YWI1LTkxOTctNjVlMzNlOGZlYWY1IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImRhdmlkQGdtYWlsLmNvbSIsIm5iZiI6MTcyNDU0NDQxNCwiY3NyZiI6ImRlMTlkMmFkLWI4MTEtNGVmNy04OWJhLTM4OWFiM2FlMDNlNyIsImV4cCI6MTczMjMyMDQxNH0.ukz-ZqBv3oeWFOvKT8kM-OY-t693ZW-ZTjMYdXsBt_U";
}
