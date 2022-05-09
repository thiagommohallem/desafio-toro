import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/onboarding/presenters/cubits/splash_logo_opacity.cubit.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  final SplashTextOpacityCubit _opacityCubit = Modular.get();

  final _logoOffsetTween =
      Tween<Offset>(begin: const Offset(0.6, 0), end: const Offset(0, 0));
  final _textOffsetTween =
      Tween<Offset>(begin: const Offset(-0.25, 0), end: const Offset(0, 0));

  @override
  void initState() {
    _initializeAnimationController();
    _startAnimations();
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Modular.to.pushNamed('/onboarding'));
    super.initState();
  }

  void _initializeAnimationController() {
    _logoAnimationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
  }

  void _startAnimations() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _logoAnimationController.forward();
      _opacityCubit.setOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(right: 200.0),
          child: SlideTransition(
            position: _logoOffsetTween.animate(_logoAnimationController),
            child: const Center(
              child: ToroLogoWidget(),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: SlideTransition(
              position: _textOffsetTween.animate(_logoAnimationController),
              child: BlocBuilder<SplashTextOpacityCubit, double>(
                bloc: _opacityCubit,
                builder: (_, state) => AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: state,
                  child: const Center(child: ToroTextWidget()),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _opacityCubit.close();
    super.dispose();
  }
}
