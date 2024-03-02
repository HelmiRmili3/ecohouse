import 'dart:io';

import 'package:ecohouse/core/features/auth/bloc/auth_bloc.dart';
import 'package:ecohouse/core/features/auth/presentation/screens/login_screen_client.dart';
import 'package:ecohouse/core/features/auth/presentation/widgets/pick_image_widget.dart';
import 'package:ecohouse/core/features/shop/presentation/screens/home_screen_client.dart';
import 'package:ecohouse/core/utils/utils.dart';
import 'package:ecohouse/values/app_strings.dart';
import 'package:ecohouse/widgets/app_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreenClient extends StatefulWidget {
  const SignUpScreenClient({super.key});
  @override
  State<SignUpScreenClient> createState() => _SignUpScreenClientState();
}

class _SignUpScreenClientState extends State<SignUpScreenClient> {
  final _formKey = GlobalKey<FormState>();

  bool isLoding = false;
  File? _selectedImage;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> passwordConfirme = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  //Image controller

  // name text filed controller
  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmeController;

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    passwordConfirmeController = TextEditingController()
      ..addListener(controllerListener);
    fullNameController = TextEditingController();
  }

  void disposeControllers() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmeController.dispose();
  }

  void controllerListener() {
    final email = emailController.text;
    final password = passwordController.text;
    final passwordConfirme = passwordConfirmeController.text;
    if (email.isEmpty && password.isEmpty && passwordConfirme.isEmpty) return;
    if (AppConstants.emailRegex.hasMatch(email) &&
        AppConstants.passwordRegex.hasMatch(password)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  Future<void> createAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        setState(() {
          isLoding = true;
        });
        await BlocProvider.of<AuthBloc>(context)
            .authRepository
            .createUser(emailController.text, passwordController.text,
                fullNameController.text, _selectedImage!)
            .then((userdata) {
              
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreenClient(),
            ),
          );
          setState(() {
            isLoding = false;
          });
        });
      } catch (e) {
        showToast('Registration failed: $e');
        setState(() {
          isLoding = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height / 6;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 45, 56, 66), Color(0xFF112232)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: appBarHeight,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 45, 56, 66), Color(0xFF112232)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextFormField(
                      controller: fullNameController,
                      labelText: "FullName",
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    AppTextFormField(
                      controller: emailController,
                      labelText: AppStrings.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterEmailAddress
                            : AppConstants.emailRegex.hasMatch(value)
                                ? null
                                : AppStrings.invalidEmailAddress;
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: passwordNotifier,
                      builder: (_, passwordObscure, __) {
                        return AppTextFormField(
                          obscureText: true,
                          controller: passwordController,
                          labelText: AppStrings.password,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? null
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: IconButton(
                            onPressed: () => passwordNotifier.value = true,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: const Icon(
                              Icons.visibility_off_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: passwordConfirme,
                      builder: (_, passwordObscure, __) {
                        return AppTextFormField(
                          obscureText: true,
                          controller: passwordConfirmeController,
                          labelText: "Confirme password",
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? null
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: IconButton(
                            onPressed: () => passwordNotifier.value = true,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: const Icon(
                              Icons.visibility_off_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return ElevatedButton(
                          onPressed: createAccount,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                return const Color.fromARGB(255, 116, 248, 8);
                              },
                            ),
                          ),
                          child: isLoding
                              ? const Center(
                                  child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircularProgressIndicator(),
                                ))
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You have an account?',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreenClient(),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 70,
          left: (MediaQuery.of(context).size.width / 2),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    _selectedImage = await pickImage();
                    setState(() {});
                  },
                  child: PickImageWidget(image: _selectedImage),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class AppConstants {
  static final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&\*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)*$');

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
}

class GradientBackground extends StatelessWidget {
  final List<Widget> children;

  const GradientBackground({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.green],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class FilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const FilledButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class Vectors {
  static const String google = 'assets/google.svg';
  static const String facebook = 'assets/facebook.svg';
}




