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
                return Column(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 600,
                          child: ListView.builder(
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 10,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 120.0,
                                      height: 120.0,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        child: Image.asset(
                                          "assets/image2.jpg", // Replace with your image URL
                                          width: 120.0,
                                          height: 120.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(state.products[index].name,
                                            style:
                                                const TextStyle(fontSize: 24)),
                                        Text(
                                          "${state.products[index].pointsPerKg} points"
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 43, 143, 48),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            ShoppingCartBloc>(
                                                        context)
                                                    .add(DecrementProduct(state
                                                        .products[index].id));
                                              },
                                              icon: const Icon(Icons.remove),
                                            ),
                                            const SizedBox(width: 10),
                                            BlocBuilder<ShoppingCartBloc,
                                                    ShoppingCartState>(
                                                builder: (context, sate) {
                                              if (state is IncrementProduct) {
                                                return Text(state
                                                    .products[index].weight
                                                    .toString());
                                              }
                                              return Text(state
                                                  .products[index].weight
                                                  .toString());
                                            }),
                                            const SizedBox(width: 10),
                                            IconButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            ShoppingCartBloc>(
                                                        context)
                                                    .add(IncrementProduct(state
                                                        .products[index].id));
                                              },
                                              icon: const Icon(Icons.add),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await BlocProvider.of<ShoppingCartBloc>(context)
                                .repository
                                .addOrder(state.products)
                                .then(
                                  (value) =>
                                      BlocProvider.of<ShoppingCartBloc>(context)
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
                                builder: (context) => const OrderScreenClient(),
                              ),
                            );
                          },
                          child: const Text("Orders"),
                        )
                      ],
                    )
                  ],
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
