class UserData {
  String displayName;
  String email;
  String uid;
  String yourPhotoUrl;

  UserData({
    required this.displayName,
    required this.email,
    required this.uid,
    required this.yourPhotoUrl,
  });

  factory UserData.fromJSON(Map<String, dynamic> json) {
    return UserData(
      displayName: json['displayName'],
      email: json['email'],
      uid: json['uid'],
      yourPhotoUrl: json['yourPhotoUrl'],
    );
  }
}