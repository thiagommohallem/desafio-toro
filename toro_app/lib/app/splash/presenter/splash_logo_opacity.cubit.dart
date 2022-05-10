import 'package:flutter_bloc/flutter_bloc.dart';

class SplashTextOpacityCubit extends Cubit<double> {
  SplashTextOpacityCubit() : super(0.0);

  void setOpacity(double opacity) {
    emit(opacity);
  }
}
