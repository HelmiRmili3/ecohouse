import 'package:ecohouse/core/features/auth/bloc/auth_bloc.dart';
import 'package:ecohouse/core/features/auth/presentation/screens/login_screen_client.dart';
import 'package:ecohouse/core/features/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenClient extends StatefulWidget {
  const ProfileScreenClient({Key? key}) : super(key: key);

  @override
  ProfileScreenClientState createState() => ProfileScreenClientState();
}

class ProfileScreenClientState extends State<ProfileScreenClient> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(UserDataFetchEvent());
  }

  bool isLoding = false;
  Future<void> logout() async {
    try {
      setState(() {
        isLoding = true;
      });
      await BlocProvider.of<AuthBloc>(context)
          .authRepository
          .signOut()
          .then((value) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreenClient()));
        setState(() {
          isLoding = false;
        });
      });
    } catch (e) {
      setState(() {
        isLoding = false;
      });
      //print('Logout failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserLoadedState) {
            //state.userModule.
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 80.0,
                          backgroundImage:
                              NetworkImage(state.userModule.imageUrl),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: ClipOval(
                            child: Container(
                              color: Colors.amber,
                              child: IconButton(
                                onPressed: () {
                                  // Your onPressed logic here
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.userModule.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  Text(
                    state.userModule.email,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                    ),
                    onPressed: null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ListTile(
                    onTap: null,
                    leading: _buildLeadingIcon(
                        Icons.person, Colors.blue.withOpacity(0.1)),
                    title: const Text("Profile"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: null,
                    leading: _buildLeadingIcon(
                        Icons.settings, Colors.blue.withOpacity(0.1)),
                    title: const Text("Settings"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: null,
                    leading: _buildLeadingIcon(
                        Icons.history, Colors.blue.withOpacity(0.1)),
                    title: const Text("History"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    onTap: null,
                    leading: !isLoding
                        ? _buildLeadingIcon(
                            Icons.logout, Colors.blue.withOpacity(0.1))
                        : const CircularProgressIndicator(),
                    title: GestureDetector(
                      onTap: logout,
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is UserErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text("Unknown error eccured !"),
            );
          }
        },
      ),
    );
  }
}

Widget _buildLeadingIcon(IconData icon, Color backgroundColor) {
  return Ink(
    decoration: BoxDecoration(
      color: backgroundColor,
      shape: BoxShape.circle,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: Colors.blue,
      ),
    ),
  );
}
