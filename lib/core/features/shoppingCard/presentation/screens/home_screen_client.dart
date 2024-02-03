import 'package:ecohouse/core/features/shoppingCard/presentation/screens/orders_screen_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecohouse/core/features/shoppingCard/bloc/shopping_card_bloc.dart';
import 'package:ecohouse/core/features/shoppingCard/bloc/shopping_card_events.dart';
import 'package:ecohouse/core/features/shoppingCard/bloc/shopping_card_states.dart';
import 'package:ecohouse/screens/profile_screen_client.dart';

class HomeScreenClient extends StatefulWidget {
  const HomeScreenClient({Key? key}) : super(key: key);

  @override
  State<HomeScreenClient> createState() => _HomeScreenClientState();
}

class _HomeScreenClientState extends State<HomeScreenClient> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShoppingCartBloc>(context).add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
            builder: (context, state) {
              if (state is ShoppingCartLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShoppingCartLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 600,
                        child: GridView.builder(
                          itemCount: state.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Set the horizontal count here
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin:const EdgeInsets.all(16.0),
                                    height: 90,
                                    width: 90,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/can_8382399.png'),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          BlocProvider.of<ShoppingCartBloc>(
                                                  context)
                                              .add(
                                            DecrementProduct(
                                                state.products[index].id),
                                          );
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      //const SizedBox(width: 8),
                                      BlocBuilder<ShoppingCartBloc,
                                              ShoppingCartState>(
                                          builder: (context, sate) {
                                        if (state is IncrementProduct) {
                                          return Text(state
                                              .products[index].weight
                                              .toString());
                                        }
                                        return Text(state.products[index].weight
                                            .toString());
                                      }),
                                      //const SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () {
                                          BlocProvider.of<ShoppingCartBloc>(
                                                  context)
                                              .add(
                                            IncrementProduct(
                                                state.products[index].id),
                                          );
                                        },
                                        icon: const Icon(Icons.add),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await BlocProvider.of<ShoppingCartBloc>(context)
                                  .repository
                                  .addOrder(state.products)
                                  .then(
                                    (value) =>
                                        BlocProvider.of<ShoppingCartBloc>(
                                                context)
                                            .add(
                                      FetchProducts(),
                                    ),
                                  )
                                  .then((value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderScreenClient(),
                                  ),
                                );
                              });
                            },
                            child: const Text("Continue"),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderScreenClient(),
                                ),
                              );
                            },
                            child: const Text("Orders"),
                          )
                        ],
                      )
                    ],
                  ),
                );
              } else if (state is ShoppingCartError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ],
      ),
    );
  }
}

AppBar buildCustomAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    title: const Text(
      'Ecohouse',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreenClient(),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 5),
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(
                          'assets/profile_avatar.jpg',
                        ), // Replace with your profile picture asset
                      ),
                      SizedBox(width: 10),
                      Center(
                        child: Text(
                          '\$ 2560',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
