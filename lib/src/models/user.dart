class UserModel {
  String id;
  String phone;
  String password;
  String token;
  String username;
  String avatar;
  String birthday;
  String genre;
  String cover_image;
  String city;
  String country;
  String description;
  String numberOfFriends;
  var requestedFriends;
  var friends;

  UserModel.empty();
  UserModel(this.id, this.avatar, this.username);

  UserModel.detail(
      this.id,
      this.avatar,
      this.username,
      this.cover_image,
      this.city,
      this.country,
      this.description,
      this.numberOfFriends,
      this.requestedFriends,
      this.friends
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['id'], json['avatar'], json['username']);
  }

  Map toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'username': username
    };
  }

  Map userTopMap() => new Map<String, dynamic>.from({
    "id": this.id,
    "username": this.username,
    "avatar": this.avatar
  });

  static List<Map> userToListMap(List<UserModel> users) {
    List<Map> usersMap =[];
    users.forEach((UserModel user) {
      Map step = user.userTopMap();
      usersMap.add(step);
    });
    return usersMap;
  }
}