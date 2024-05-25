import 'package:api_clean_arch/core/error/failures.dart';
import 'package:api_clean_arch/features/cats/data/models/cat_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CatRepository {
  Future<Either<Failure, List<Root?>>> getCats();
}
