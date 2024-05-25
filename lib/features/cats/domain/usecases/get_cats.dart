import 'package:api_clean_arch/core/error/failures.dart';
import 'package:api_clean_arch/core/usecase/usecase.dart';
import 'package:api_clean_arch/features/cats/data/models/cat_model.dart';
import 'package:api_clean_arch/features/cats/domain/repository/cats_repository.dart';
import 'package:fpdart/src/either.dart';

class GetCats implements UseCase<List<Root?>, GetCatsParams> {
  final CatRepository catRepository;
  GetCats(this.catRepository);
  @override
  Future<Either<Failure, List<Root?>>> call(GetCatsParams params) async {
    return await catRepository.getCats();
  }
}

class GetCatsParams {}
