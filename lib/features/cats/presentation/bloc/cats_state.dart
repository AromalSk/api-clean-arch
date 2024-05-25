part of 'cats_bloc.dart';

@immutable
sealed class CatsState {}

final class CatsInitial extends CatsState {}

final class CatsLoading extends CatsState {}

final class CatsSuccess extends CatsState {
  final List<Root?> catDetails;
  CatsSuccess(this.catDetails);
}

final class CatsFailure extends CatsState {
  final String message;
  CatsFailure(this.message);
}
