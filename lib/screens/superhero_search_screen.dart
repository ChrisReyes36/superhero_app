import 'dart:async';

import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/repository.dart';
import 'package:superhero_app/screens/superhero_detail_screen.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  Future<SuperheroResponse?>? _superheroInfo;
  Repository repository = Repository();
  bool _isTextEmpty = true;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Superhero Search")),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Busca un superhéroe",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() => _isTextEmpty = value.isEmpty);
                  _debounce?.cancel();
                  if (value.isEmpty) return;
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      _superheroInfo = repository.fetchSuperheroInfo(value);
                    });
                  });
                },
              ),
            ),
            bodyList(_isTextEmpty),
          ],
        ),
      ),
    );
  }

  FutureBuilder<SuperheroResponse?> bodyList(bool isTextEmpty) {
    return FutureBuilder(
      future: _superheroInfo,
      builder: (context, snapshot) {
        if (_isTextEmpty) return Center(child: Text("Introduce un nombre"));

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var superheroList = snapshot.data?.result;
          if (superheroList == null || superheroList.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Text("No hay resultados"),
            );
          }
          return Expanded(
            child: ListView.builder(
              itemCount: superheroList.length,
              itemBuilder: (context, index) =>
                  itemSuperhero(superheroList[index]),
            ),
          );
        } else {
          return Text("No hay resultados");
        }
      },
    );
  }

  Padding itemSuperhero(SuperheroDetailResponse item) => Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuperheroDetailScreen(superhero: item),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.red,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.url,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.6),
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.white);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
