import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:toro_app/app/modules/onboarding/presenters/usecases/open_url.usecase.dart';

part 'open_url_state.dart';

class OpenToroSignUpUrlCubit extends Cubit<OpenUrlState> {
  final IOpenUrlUsecase _openUrlUsecase;

  OpenToroSignUpUrlCubit(this._openUrlUsecase) : super(OpenUrlInitial());

  Future<void> openUrl() async {
    final result =
        await _openUrlUsecase("https://cadastro.toroinvestimentos.com.br/");
    result.fold((l) => emit(OpenUrlErrorState()), (r) {
      if (r) {
        emit(OpenUrlInitial());
      } else {
        emit(OpenUrlErrorState());
      }
    });
  }

  @override
  Future<void> close() {
    _openUrlUsecase.dispose();
    return super.close();
  }
}
