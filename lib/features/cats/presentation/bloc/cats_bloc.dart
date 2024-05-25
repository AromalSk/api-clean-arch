import 'package:api_clean_arch/features/cats/data/models/cat_model.dart';
import 'package:api_clean_arch/features/cats/domain/usecases/get_cats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cats_event.dart';
part 'cats_state.dart';

class CatsBloc extends Bloc<CatsEvent, CatsState> {
  final GetCats _getCats;
  CatsBloc({required GetCats getCats})
      : _getCats = getCats,
        super(CatsInitial()) {
    on<CallCats>((event, emit) async {
      emit(CatsLoading());
      final res = await _getCats(GetCatsParams());

      res.fold(
          (l) => emit(CatsFailure(l.message)), (r) => emit(CatsSuccess(r)));
    });
  }
}
