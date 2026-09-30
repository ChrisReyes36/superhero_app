import 'package:flutter/material.dart';
import 'package:superhero_app/components/stat_bar.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superhero;

  const SuperheroDetailScreen({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Superhero {{ ${superhero.name} }}")),
      body: Column(
        children: [
          Image.network(
            superhero.url,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: Alignment(0, -0.6),
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, color: Colors.red);
            },
          ),
          Text(superhero.name, style: TextStyle(fontSize: 28)),
          Text(
            superhero.realName,
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          SizedBox(
            width: double.infinity,
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StatBar(
                  label: "Power",
                  value: superhero.powerStatsResponse.power,
                  color: Colors.red,
                ),
                StatBar(
                  label: "Strength",
                  value: superhero.powerStatsResponse.strength,
                  color: Colors.grey,
                ),
                StatBar(
                  label: "Intelligence",
                  value: superhero.powerStatsResponse.intelligence,
                  color: Colors.blue,
                ),
                StatBar(
                  label: "Speed",
                  value: superhero.powerStatsResponse.speed,
                  color: Colors.amberAccent,
                ),
                StatBar(
                  label: "Durability",
                  value: superhero.powerStatsResponse.durability,
                  color: Colors.deepOrange,
                ),
                StatBar(
                  label: "Combat",
                  value: superhero.powerStatsResponse.combat,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
