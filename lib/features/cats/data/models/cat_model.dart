import 'package:api_clean_arch/features/cats/domain/entities/root_entity.dart';

class Breed extends BreedEntity {
  Breed({
    String? id,
    String? name,
    String? vetstreeturl,
    String? vcahospitalsurl,
    String? temperament,
    String? origin,
    String? description,
    String? lifespan,
    String? wikipediaurl,
  }) : super(
          id: id,
          name: name,
          vetstreetUrl: vetstreeturl,
          vcahospitalsUrl: vcahospitalsurl,
          temperament: temperament,
          origin: origin,
          description: description,
          lifeSpan: lifespan,
          wikipediaUrl: wikipediaurl,
        );

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'],
      name: json['name'],
      vetstreeturl: json['vetstreet_url'],
      vcahospitalsurl: json['vcahospitals_url'],
      temperament: json['temperament'],
      origin: json['origin'],
      description: json['description'],
      lifespan: json['life_span'],
      wikipediaurl: json['wikipedia_url'],
    );
  }
}

class Root extends RootEntity {
  Root({
    List<BreedEntity?>? breeds,
    String? id,
    String? url,
    int? width,
    int? height,
  }) : super(
          breeds: breeds,
          id: id,
          url: url,
          width: width,
          height: height,
        );

  factory Root.fromJson(Map<String, dynamic> json) {
    List<BreedEntity?>? breedsList;
    if (json['breeds'] != null) {
      breedsList = <BreedEntity>[];
      json['breeds'].forEach((v) {
        breedsList!.add(Breed.fromJson(v));
      });
    }

    return Root(
      breeds: breedsList,
      id: json['id'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}
