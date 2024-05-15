class UserModel {
  final String uid;
  final String email;
  final int point;
  final String durum;
  final String kelime;
  final String ad;

  const UserModel({
    required this.uid,
    required this.email,
    required this.point,
    required this.durum,
    required this.kelime,
    required this.ad,
  });

  factory UserModel.fromFirestore(Map map, String uid) {
    return UserModel(
      uid: uid,
      ad: map['ad'],
      durum: map['durum'],
      email: map['email'],
      kelime: map['kelime'],
      point: map['point'],
    );
  }
}
