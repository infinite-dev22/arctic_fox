import 'package:smart_rent/models/general/smart_model.dart';

class PropertyTypeG extends SmartModel {
  final int id;
  final String name;

  PropertyTypeG({required this.id, required this.name});

  static List<PropertyTypeG> propertyTypes = [
    PropertyTypeG(id: 1, name: 'Commercial'),
    PropertyTypeG(id: 2, name: 'Residential'),
    PropertyTypeG(id: 3, name: 'Residential & Commercial'),
  ];

  @override
  int getId() {
    return id;
  }

  @override
  String getName() {
    return name;
  }
}

class PropertyCategoryTypeG extends SmartModel {
  final int id;
  final String name;

  PropertyCategoryTypeG({required this.id, required this.name});

  static List<PropertyCategoryTypeG> propertyCategoryTypes = [
    PropertyCategoryTypeG(id: 1, name: 'Plaza'),
    PropertyCategoryTypeG(id: 2, name: 'Mall'),
  ];

  @override
  int getId() {
    return id;
  }

  @override
  String getName() {
    return name;
  }
}
