import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_web/features/auth/login/cubit/login_cubit.dart';
import 'package:test_flutter_web/features/auth/login/cubit/login_cubit_states.dart';
import 'package:validatorless/validatorless.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginCubit = LoginCubit();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    // ignore: no_leading_underscores_for_local_identifiers
    bool _obscureText = true;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.topCenter,
        child: BlocBuilder<LoginCubit, LoginCubitState>(
          bloc: loginCubit,
          builder: (context, state) {
            if (state is LoginLoggedState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/home');
              });
            }
            if (state is LoginErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            return Column(
              children: [
                SizedBox(
                  height: sizeOf.height * .4,
                  child: Image.asset('assets/images/new_logo.png'),
                ),
                Container(
                  width: sizeOf.width * .5,
                  margin: const EdgeInsets.only(top: 80),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Bem vindo!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: emailEC,
                          validator: Validatorless.multiple([
                            Validatorless.email('Digite um email correto!'),
                            Validatorless.required('Email não pode ser vazio'),
                          ]),
                          decoration: const InputDecoration(
                            label: Text('Email'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          obscureText: _obscureText,
                          controller: passwordEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Senha não pode ser vazia'),
                            Validatorless.min(6, 'Senha muito curta'),
                          ]),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye),
                            ),
                            label: const Text('Senha'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            final valid = formKey.currentState?.validate() ?? false;
                            if (valid) {
                              loginCubit.loginAdmUser(
                                email: emailEC.text,
                                password: passwordEC.text,
                              );
                            }
                          },
                          child: state is LoginLoadingState
                              ? const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: CircularProgressIndicator(),
                                )
                              : const Text('ENTRAR'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
