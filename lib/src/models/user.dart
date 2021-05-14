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
}