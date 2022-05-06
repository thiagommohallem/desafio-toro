import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toro_app/app/modules/onboarding/domain/usecases/open_url.usecase.dart';

class OpenToroSignUpUrlCubit extends Cubit<bool?> {
  final IOpenUrlUsecase _openUrlUsecase;
  OpenToroSignUpUrlCubit(this._openUrlUsecase) : super(null);

  Future<void> openUrl() async {
    emit(await _openUrlUsecase("https://cadastro.toroinvestimentos.com.br/"));
  }
}
