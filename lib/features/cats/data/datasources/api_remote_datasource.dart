import 'dart:convert';
import 'package:api_clean_arch/core/error/exceptions.dart';
import 'package:api_clean_arch/core/secrets/app_secrets.dart';
import 'package:api_clean_arch/features/cats/data/models/cat_model.dart';
import 'package:http/http.dart' as http;

abstract interface class ApiRemoteDataSource {
  Future<List<Root?>> getCats();
}

class ApiRemoteDataSourceImpl implements ApiRemoteDataSource {
  @override
  Future<List<Root?>> getCats() async {
    try {
      final response = await http.get(Uri.parse(AppSecrets.catUrl));

      if (response.statusCode == 200) {
        final List<dynamic> result = jsonDecode(response.body);

        final List<Root?> roots = [];

        for (dynamic x in result) {
          roots.add(Root.fromJson(x));
        }
        return roots;
      } else {
        throw Exception('Failed to load cat breeds');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
