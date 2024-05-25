class BreedEntity {
  final String? id;
  final String? name;
  final String? vetstreetUrl;
  final String? vcahospitalsUrl;
  final String? temperament;
  final String? origin;
  final String? description;
  final String? lifeSpan;
  final String? wikipediaUrl;

  BreedEntity({
    this.id,
    this.name,
    this.vetstreetUrl,
    this.vcahospitalsUrl,
    this.temperament,
    this.origin,
    this.description,
    this.lifeSpan,
    this.wikipediaUrl,
  });
}

class RootEntity {
  final List<BreedEntity?>? breeds;
  final String? id;
  final String? url;
  final int? width;
  final int? height;

  RootEntity({this.breeds, this.id, this.url, this.width, this.height});
}
