import 'package:api_clean_arch/core/error/exceptions.dart';
import 'package:api_clean_arch/core/error/failures.dart';
import 'package:api_clean_arch/features/cats/data/datasources/api_remote_datasource.dart';
import 'package:api_clean_arch/features/cats/data/models/cat_model.dart';
import 'package:api_clean_arch/features/cats/domain/repository/cats_repository.dart';
import 'package:fpdart/fpdart.dart';

class CatRepositoryImpl implements CatRepository {
  final ApiRemoteDataSource remoteDataSource;

  CatRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<Root?>>> getCats() async {
    try {
      final cats = await remoteDataSource.getCats();

      return right(cats);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
