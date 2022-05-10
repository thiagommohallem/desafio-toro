import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toro_app/app/modules/login/presenters/cubits/sign_in_cubit.dart';
import 'package:toro_app/app/modules/login/ui/helpers/email_validator.dart';
import 'package:toro_app/colors.dart';
import 'package:toro_app/common/widgets/toro_elevated_button.widget.dart';
import 'package:toro_app/common/widgets/toro_error_alert_dialog.widget.dart';
import 'package:toro_app/common/widgets/toro_row_with_logo_and_text.widget.dart';
import 'package:toro_app/common/widgets/toro_text_form_field.widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final SignInCubit _signInCubit = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, bottom: 14.0, left: 24, right: 24),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const ToroRowWithLogoAndTextWidget(),
                  const SizedBox(
                    height: 30,
                  ),
                  _title(),
                  const SizedBox(height: 50),
                  _body(context),
                  const SizedBox(
                    height: 30,
                  ),
                  const Spacer(),
                  _loginButton(),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  RichText _title() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        children: [
          TextSpan(text: "O jeito mais fácil de "),
          TextSpan(text: "investir", style: TextStyle(color: toroPrimaryColor)),
          TextSpan(text: " na Bolsa."),
        ],
      ),
    );
  }

  BlocBuilder<SignInCubit, SignInState> _body(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      bloc: _signInCubit,
      builder: (_, state) {
        if (state is SignInError) {
          WidgetsBinding.instance!.addPostFrameCallback(
            (timeStamp) {
              showDialog(
                context: context,
                builder: (_) {
                  return ToroErrorAlertDialog(
                    text: Text(
                      state.exception.message,
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                },
              );
              _signInCubit.returnToInitialState();
            },
          );
          return _form();
        }
        if (state is SignInLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: toroPrimaryColor,
          ));
        }
        if (state is SignInInitial) {
          return _form();
        } else {
          Modular.to.pushReplacementNamed('/login/home/');
          return Container();
        }
      },
    );
  }

  Form _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ToroTextFormField(
            label: "E-mail",
            controller: _emailController,
            validator: (email) {
              if (email == null || email.isEmpty) return "Digite um e-mail";
              if (!isEmailValid(email)) {
                return "E-mail inválido";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 32,
          ),
          ToroTextFormField(
            label: "Senha",
            obscureText: true,
            validator: (password) {
              if (password == null || password.isEmpty) {
                return "Digite uma senha";
              }
              if (password.length < 6) {
                return "A senha tem no mínimo 6 caracteres";
              }
              return null;
            },
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  Hero _loginButton() {
    return Hero(
      tag: 'login-button',
      child: ToroElevatedButtonWidget(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await _signInCubit.signIn(
                email: _emailController.text,
                password: _passwordController.text);
          }
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
    _emailController.dispose();
    _passwordController.dispose();
    _signInCubit.close();
    super.dispose();
  }
}
