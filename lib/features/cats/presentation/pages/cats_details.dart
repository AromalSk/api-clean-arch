import 'package:flutter/material.dart';

class BreedImagesScreen extends StatelessWidget {
  final String breedName;
  final String breedImage;
  final String description;
  final String origin;
  final String lifeSpan;
  BreedImagesScreen(
      {required this.breedName,
      required this.breedImage,
      required this.description,
      required this.origin,
      required this.lifeSpan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Details of $breedName',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  '$breedImage',
                  fit: BoxFit.contain,
                  height: 300,
                  width: 300,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Breed: $breedName',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Origin : $origin",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  '$description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "LifeSpan : $lifeSpan",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
