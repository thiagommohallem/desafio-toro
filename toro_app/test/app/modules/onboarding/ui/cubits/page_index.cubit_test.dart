import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toro_app/app/modules/onboarding/ui/cubits/page_index.cubit.dart';

void main() {
  group("PageIndexCubit tests...", () {
    blocTest<PageIndexCubit, int>(
      "Page index cubit emits 10 when seeded with 10",
      build: () => PageIndexCubit(),
      act: (bloc) => bloc.selectPage(10),
      expect: () => [10],
    );
  });
}
