class Pokemon {
  final int id;
  final String num;
  final String name;
  final String img;
  final List<String> type;
  final String height;
  final String weight;
  final String candy;
  final int candyCount;
  final String egg;
  final double spawnChance;
  final double avgSpawns;
  final String spawnTime;
  final List<double> multipliers;
  final List<String> weaknesses;
  final List<NextEvolution> nextEvolution;

  const Pokemon(
      {required this.id,
      required this.num,
      required this.name,
      required this.img,
      required this.type,
      required this.height,
      required this.weight,
      required this.candy,
      required this.candyCount,
      required this.egg,
      required this.spawnChance,
      required this.avgSpawns,
      required this.spawnTime,
      required this.multipliers,
      required this.weaknesses,
      required this.nextEvolution});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] ?? 0,
      num: json['num'] ?? '',
      name: json['name'] ?? '',
      img: json['img'],
      type: json['type'] != null
          ? List<String>.from(json['type'].map((x) => x.toString()))
          : [],
      height: json['height'],
      weight: json['weight'],
      candy: json['candy'],
      candyCount: json['candy_count'] ?? 0,
      egg: json['egg'],
      spawnChance: json['spawn_chance']?.toDouble() ?? 0.0,
      avgSpawns: json['avg_spawns'] != null ? json['avg_spawns'].toDouble() : 0,
      spawnTime: json['spawn_time'],
      multipliers: json['multipliers'] != null
          ? List<double>.from(json['multipliers'].map((x) => x.toDouble()))
          : [],
      weaknesses: json['weaknesses'] != null
          ? List<String>.from(json['weaknesses'])
          : [],
      nextEvolution: json['next_evolution'] != null
          ? List<NextEvolution>.from(
              json['next_evolution'].map((x) => NextEvolution.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['num'] = num;
    data['name'] = name;
    data['img'] = img;
    data['type'] = type;
    data['height'] = height;
    data['weight'] = weight;
    data['candy'] = candy;
    data['candy_count'] = candyCount;
    data['egg'] = egg;
    data['spawn_chance'] = spawnChance;
    data['avg_spawns'] = avgSpawns;
    data['spawn_time'] = spawnTime;
    data['multipliers'] = multipliers;
    data['weaknesses'] = weaknesses;
    data['next_evolution'] = nextEvolution.map((v) => v.toJson()).toList();
    return data;
  }
}

class NextEvolution {
  String? num;
  String? name;

  NextEvolution({this.num, this.name});

  NextEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['name'] = name;
    return data;
  }
}
