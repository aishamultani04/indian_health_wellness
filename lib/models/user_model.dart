class UserModel {
  final String name;
  final String age;
  final String height;
  final String weight;
  final String gender;
  final String activityLevel;
  final String? prakriti;

  UserModel({
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.activityLevel,
    this.prakriti,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'activityLevel': activityLevel,
      'prakriti': prakriti,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      age: json['age'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      gender: json['gender'] ?? 'Male',
      activityLevel: json['activityLevel'] ?? 'Moderate',
      prakriti: json['prakriti'],
    );
  }
}