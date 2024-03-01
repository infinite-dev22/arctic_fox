abstract class CountryCityRepository {
  Future<List<String>> fetchCountries();

  Future<List<String>> fetchCities(String country);
}
