import 'package:ecohouse/core/features/auth/bloc/auth_bloc.dart';
import 'package:ecohouse/core/features/auth/bloc/auth_states.dart';
import 'package:ecohouse/core/features/auth/presentation/screens/login_screen_client.dart';
import 'package:ecohouse/core/features/auth/repository/auth_repository.dart';
import 'package:ecohouse/core/features/shoppingCard/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/shoppingCard/repository/shopping_card_repository.dart';
import 'package:ecohouse/core/features/user/bloc/user_bloc.dart';
import 'package:ecohouse/core/features/user/repository/user_repository.dart';
import 'package:ecohouse/firebase_options.dart';
import 'package:ecohouse/core/features/shoppingCard/presentation/screens/home_screen_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // print('Failed to initialize Firebase: $e');
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(),
          ),
        ),
        BlocProvider(
          create: ((context) => ShoppingCartBloc(
                repository: ShoppingCardRepository(),
              )),
        ),
        BlocProvider(
          create: ((context) => UserBloc(
                userRepository: UserRepository(),
              )),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecohouse',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
