import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/onboarding/presenters/cubits/open_url_cubit.dart';
import 'package:toro_app/app/modules/onboarding/presenters/cubits/page_index.cubit.dart';
import 'package:toro_app/app/modules/onboarding/ui/widgets/onboarding_page_four.widget.dart';
import 'package:toro_app/app/modules/onboarding/ui/widgets/onboarding_page_one.widget.dart';
import 'package:toro_app/app/modules/onboarding/ui/widgets/onboarding_page_three.widget.dart';
import 'package:toro_app/app/modules/onboarding/ui/widgets/onboarding_page_two.widget.dart';
import 'package:toro_app/colors.dart';
import 'package:toro_app/common/utils/media_query_converter.dart';
import 'package:toro_app/common/widgets/toro_elevated_button.widget.dart';
import 'package:toro_app/common/widgets/toro_error_alert_dialog.widget.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageIndexCubit _pageIndexCubit = Modular.get();

  final OpenToroSignUpUrlCubit _openUrlCubit = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OpenToroSignUpUrlCubit, OpenUrlState>(
        bloc: _openUrlCubit,
        builder: (context, state) {
          if (state is OpenUrlErrorState) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (_) => const ToroErrorAlertDialog(
                  text: SelectableText(
                    "Ops, ocorreu um erro ao abrir o site",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            });
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, bottom: 14.0, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _logoAndToroText(),
                  const Spacer(),
                  _onboardingPageView(context),
                  const SizedBox(height: 24),
                  _dotsIndicator(),
                  const Spacer(
                    flex: 2,
                  ),
                  _openAccountButton(context),
                  const SizedBox(
                    height: 16,
                  ),
                  _loginButton(),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row _logoAndToroText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ToroLogoWidget(
          width: 50,
          height: 50,
        ),
        SizedBox(
          width: 10,
        ),
        ToroTextWidget(
          width: 150,
          height: 50,
        )
      ],
    );
  }

  SizedBox _onboardingPageView(BuildContext context) {
    return SizedBox(
      height: baseHeightConverter(context, 350),
      child: PageView(
        onPageChanged: (page) => _pageIndexCubit.selectPage(page),
        children: const [
          OnboardingPageOne(),
          OnboardingPageTwo(),
          OnboardingPageThree(),
          OnboardingPageFour(),
        ],
      ),
    );
  }

  BlocBuilder<PageIndexCubit, int> _dotsIndicator() {
    return BlocBuilder<PageIndexCubit, int>(
      bloc: _pageIndexCubit,
      builder: (_, state) {
        return DotsIndicator(
          dotsCount: 4,
          position: state.toDouble(),
          decorator: const DotsDecorator(activeColor: toroPrimaryColor),
        );
      },
    );
  }

  ToroElevatedButtonWidget _openAccountButton(BuildContext context) {
    return ToroElevatedButtonWidget(
      onPressed: () async {
        await _openUrlCubit.openUrl();
      },
      child: const Text(
        "Abra sua conta grátis",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Hero _loginButton() {
    return Hero(
      tag: 'login-button',
      child: ToroElevatedButtonWidget(
        onPressed: () {
          Modular.to.navigate('/login/');
        },
        child: const Text(
          "Entrar",
          style: TextStyle(fontSize: 16),
        ),
        color: Colors.grey,
      ),
    );
  }

  @override
  void dispose() {
    _openUrlCubit.close();
    _pageIndexCubit.close();
    super.dispose();
  }
}
