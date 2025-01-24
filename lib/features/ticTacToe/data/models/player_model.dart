class PlayerModel {
  final int id;
  final String name;
  final String image;

  PlayerModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
  }
}
