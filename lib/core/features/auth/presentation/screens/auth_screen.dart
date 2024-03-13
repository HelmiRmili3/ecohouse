import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_states.dart';
import 'login_screen_client.dart';
import '../../../home/presentation/screens/home_screen_client.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitialState) {
          return const LoginScreenClient();
        } else if (state is AuthSignedInState) {
          return const HomeScreenClient();
        } else if (state is AuthSignedOutState) {
          return const LoginScreenClient();
        } else if (state is AuthErrorState) {
          return Text('Error: ${state.error}');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
