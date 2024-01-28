import 'package:flutter/material.dart';

class OrderScreenClient extends StatefulWidget {
  const OrderScreenClient({super.key});

  @override
  State<OrderScreenClient> createState() => _OrderScreenClientState();
}

class _OrderScreenClientState extends State<OrderScreenClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text("Text1", style: TextStyle(fontSize: 24)),
                        const Text(
                          "text2",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 43, 143, 48),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove),
                            ),
                            const Text("example"),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {},
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
    );
  }
}
