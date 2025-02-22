﻿import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/login/controllers/login_controller.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    final Validators validationService = Validators();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final imageHeight = constraints.maxHeight / 3;
                  return Container(
                    color: const Color(0xFFFFDE59),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('resources/images/app_banner.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      height: imageHeight,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          controller.setUsername(value);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Seu email ou usuário',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: validationService.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          controller.setPassword(value);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Sua senha',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                        validator: validationService.validatePassword,
                      ),
                      const SizedBox(height: 32),
                      Consumer<LoginController>(
                        builder: (context, value, child) {
                          return value.isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ?? false) {
                                      value.login(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                    foregroundColor: Colors.black,
                                  ),
                                  child: const Text('Entrar'),
                                );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ScreensRoutes.userRegister);
                        },
                        child: const Text(
                          'Cadastrar-se',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
