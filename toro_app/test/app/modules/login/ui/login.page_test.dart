import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:toro_app/app/modules/login/domain/errors/auth_exception.dart';
import 'package:toro_app/app/modules/login/domain/model/user.model.dart';
import 'package:toro_app/app/modules/login/module/login.module.dart';
import 'package:toro_app/app/modules/login/presenters/cubits/sign_in_cubit.dart';
import 'package:toro_app/app/modules/login/ui/login.page.dart';
import 'package:toro_app/common/widgets/toro_elevated_button.widget.dart';
import 'package:toro_app/common/widgets/toro_error_alert_dialog.widget.dart';
import 'package:toro_app/common/widgets/toro_logo.widget.dart';
import 'package:toro_app/common/widgets/toro_text.widget.dart';
import 'package:toro_app/common/widgets/toro_text_form_field.widget.dart';

import 'login.page_test.mocks.dart';

@GenerateMocks([SignInCubit, IModularNavigator])
void main() {
  MockSignInCubit _mockSignInCubit = MockSignInCubit();
  MockIModularNavigator _navigatorMock = MockIModularNavigator();

  setUpAll(() {
    Modular.navigatorDelegate = _navigatorMock;
    initModule(LoginModule(),
        replaceBinds: [Bind.factory<SignInCubit>((i) => _mockSignInCubit)]);
  });

  setUp(() {
    when(_mockSignInCubit.stream)
        .thenAnswer((realInvocation) => Stream.fromIterable([]));
  });

  group("LoginPage widget tests...", () {
    testWidgets('Should display initial widgets', (tester) async {
      when(_mockSignInCubit.state).thenReturn(SignInInitial());
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      final _toroLogo = find.byWidgetPredicate((widget) =>
          widget is ToroLogoWidget &&
          widget.width == 40.0 &&
          widget.height == 40.0);
      expect(_toroLogo, findsOneWidget);

      final _toroText = find.byWidgetPredicate((widget) =>
          widget is ToroTextWidget &&
          widget.width == 110 &&
          widget.height == 40);
      expect(_toroText, findsOneWidget);

      final title = find.text(
        "O jeito mais fácil de investir na Bolsa.",
        findRichText: true,
      );
      expect(title, findsOneWidget);

      final _loginButton = _findLoginButton();
      expect(_loginButton, findsOneWidget);

      final _emailInputField = _findEmailField();

      expect(_emailInputField, findsOneWidget);
      final _passwordInputField = _findPasswordField();

      expect(_passwordInputField, findsOneWidget);
    });

    testWidgets('Should display empty fields validations', (tester) async {
      when(_mockSignInCubit.state).thenReturn(SignInInitial());
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await _findAndTapLoginButton(tester);

      final emptyEmailText = find.text("Digite um e-mail");
      expect(emptyEmailText, findsOneWidget);
      final emptyPasswordText = find.text("Digite uma senha");
      expect(emptyPasswordText, findsOneWidget);
    });

    testWidgets('Should display invalid email message when email is invalid',
        (tester) async {
      when(_mockSignInCubit.state).thenReturn(SignInInitial());
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      final _emailField = _findEmailField();
      expect(_emailField, findsOneWidget);

      await tester.enterText(_emailField, "a");

      await _findAndTapLoginButton(tester);

      final invalidEmailText = find.text("E-mail inválido");
      expect(invalidEmailText, findsOneWidget);
    });

    testWidgets(
        'Should display password invalid message when password has less than 6 chars',
        (tester) async {
      when(_mockSignInCubit.state).thenReturn(SignInInitial());
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      final _passwordField = _findPasswordField();
      expect(_passwordField, findsOneWidget);

      await tester.enterText(_passwordField, "123");

      await _findAndTapLoginButton(tester);

      final invalidPasswordText =
          find.text("A senha tem no mínimo 6 caracteres");
      expect(invalidPasswordText, findsOneWidget);
    });

    testWidgets('Should call sign In when form fields are valid',
        (tester) async {
      when(_mockSignInCubit.state).thenReturn(SignInInitial());
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      final _passwordField = _findPasswordField();
      expect(_passwordField, findsOneWidget);
      final _emailField = _findEmailField();
      expect(_emailField, findsOneWidget);

      await tester.enterText(_emailField, "teste@gmail.com");
      await tester.enterText(_passwordField, "123456");

      await _findAndTapLoginButton(tester);

      verify(_mockSignInCubit.signIn(
              email: 'teste@gmail.com', password: '123456'))
          .called(1);
    });

    testWidgets('Should display error when SignInError state is emitted',
        (tester) async {
      when(_mockSignInCubit.state)
          .thenReturn(SignInError(UserNotFoundException(message: '')));
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.pumpAndSettle();
      final _errorDialog = find.byType(ToroErrorAlertDialog);
      expect(_errorDialog, findsOneWidget);
      verify(_mockSignInCubit.returnToInitialState()).called(1);
    });

    testWidgets('Should return loading when SignInLoading state is emitted',
        (tester) async {
      when(_mockSignInCubit.state).thenReturn(SignInLoading());
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      final _loading = find.byType(CircularProgressIndicator);
      expect(_loading, findsOneWidget);
    });

    testWidgets('Should push home route when sign in is success',
        (tester) async {
      when(_mockSignInCubit.state).thenReturn(SignInSuccess(User('', '')));
      when(_navigatorMock.pushReplacementNamed(any))
          .thenAnswer((realInvocation) async => true);
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      verify(_navigatorMock.pushReplacementNamed('/login/home/')).called(1);
    });
  });
}

Future<void> _findAndTapLoginButton(WidgetTester tester) async {
  final _loginButton = _findLoginButton();
  expect(_loginButton, findsOneWidget);
  await tester.ensureVisible(_loginButton);
  await tester.tap(_loginButton);
  await tester.pumpAndSettle();
}

Finder _findEmailField() {
  return find.byWidgetPredicate(
      (widget) => widget is ToroTextFormField && widget.label == "E-mail");
}

Finder _findPasswordField() {
  return find.byWidgetPredicate(
      (widget) => widget is ToroTextFormField && widget.label == "Senha");
}

Finder _findLoginButton() =>
    find.widgetWithText(ToroElevatedButtonWidget, "Entrar");
