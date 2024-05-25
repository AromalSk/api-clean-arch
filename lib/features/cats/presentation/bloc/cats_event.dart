part of 'cats_bloc.dart';

@immutable
sealed class CatsEvent {}

final class CallCats extends CatsEvent {}
