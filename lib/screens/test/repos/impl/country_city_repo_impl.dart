import 'package:smart_rent/screens/test/repos/interfaces/country_city_repo.dart';

class FakeCountryCityRepository implements CountryCityRepository {
  @override
  Future<List<String>> fetchCountries() async {
    return ['USA', 'Canada', 'UK'];
  }

  @override
  Future<List<String>> fetchCities(String country) async {
    final cities = {
      'USA': ['New York', 'Los Angeles', 'Chicago'],
      'Canada': ['Toronto', 'Vancouver', 'Montreal'],
      'UK': ['London', 'Manchester', 'Liverpool'],
    };
    return cities[country] ?? [];
  }
}
