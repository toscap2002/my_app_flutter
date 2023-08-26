class Constants {
  // Setta la API KEY per effettuare tutte le richieste
  static const String API_KEY = "";

  /* Per ora lascio il player tag in questo modo per motivi di test, successivamente va messo
     il tag del giocatore registrato */
  static const String PLAYER_TAG = "%23PGJVQUJJL";
  static const String PLAYERS_URL = "https://api.clashofclans.com/v1/players/$PLAYER_TAG";

  // URL per i vari ranking
  static const String LOCATION_ID = ""; // 32000000 - Europe (per accedere alle altre cambia le ultime cifre!)
  static const String GET_LOCATIONS = "https://api.clashofclans.com/v1/locations";
  static const String RANKING_CLANS_NORMAL = "https://api.clashofclans.com/v1/locations/$LOCATION_ID/rankings/clans";
  static const String RANKING_CLANS_BUILDER = "https://api.clashofclans.com/v1/locations/$LOCATION_ID/rankings/clans-versus";
  static const String RANKING_CLANS_CAPITAL = "https://api.clashofclans.com/v1/locations/$LOCATION_ID/rankings/capitals";
  static const String RANKING_PLAYERS_NORMAL = "https://api.clashofclans.com/v1/locations/$LOCATION_ID/rankings/players";
  static const String RANKING_PLAYERS_BUILDER = "https://api.clashofclans.com/v1/locations/$LOCATION_ID/rankings/players-builder-base";
}





