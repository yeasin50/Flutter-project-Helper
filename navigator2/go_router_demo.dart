///*  go_router: ^5.1.0
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Item {
  final int id;
  final String description;
  Item({
    required this.id,
    required this.description,
  });
}

final data = List.generate(
    33,
    (index) => Item(
        id: index,
        description:
            "this is an ${index.isEven ? "even" : "odd"} item : $index"));

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: "/",
          name: "Home",
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
            path: "/details",
            name: "details",
            builder: (context, state) {
              final int id = int.tryParse(state.queryParams["id"] ?? "") ??
                  0; //todo: handle unknown page

              log(id.toString());
              final item = data.firstWhere((element) => element.id == id);

              return DetailsPage(
                item: item,
              );
            }),
      ],
      errorBuilder: (context, state) {
        return const Scaffold(
          body: Center(
            child: Text("404"),
          ),
        );
      },
    );
    return MaterialApp.router(routerConfig: router);
  }
}

///** 


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Text("item ${item.id}"),
              onTap: () {
                GoRouter.of(context).goNamed(
                  "details",
                  queryParams: {"id": item.id.toString()},
                );
              },
            );
          }),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    this.item,
  });
  final Item? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            title: Text("${item?.id}"),
            subtitle: Text("${item?.description}"),
          )
        ],
      ),
    );
  }
}
