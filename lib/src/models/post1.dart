class Post {
  final String? profileImageUrl;
  final String? username;
  final String? time;
  final String? content;
  final String? likes;
  final String? comments;
  final String? shares;

  Post(
      {this.profileImageUrl,
      this.username,
      this.time,
      this.content,
      this.likes,
      this.comments,
      this.shares});
}

List<Post> posts = [
  new Post(profileImageUrl: 'assets/avatar.jpg', username: 'Lương Anh Tuấn', time: '5 giờ', content: 'The runApp() function takes the given Widget and makes it the root of the widget tree.', likes: '63', comments: '11', shares: '2'),
  new Post(profileImageUrl: 'assets/avatar.jpg', username: 'Trọng Tu', time: '13 giờ', content: 'The framework forces the root widget to cover the screen, which means the text “Hello, world” ends up centered on screen. The text direction needs to be specified in this instance; when the MaterialApp widget is used, this is taken care of for you, as demonstrated later.', likes: '52', comments: '1', shares: '6'),
  new Post(profileImageUrl: 'assets/avatar.jpg', username: 'Đức Hải', time: '1 ngày', content: 'When writing an app, you’ll commonly author new widgets that are subclasses of either StatelessWidget or StatefulWidget, depending on whether your widget manages any state. ', likes: '61', comments: '3', shares: '2'),
  new Post(profileImageUrl: 'assets/avatar.jpg', username: 'Thọ', time: '1 ngày', content: 'A widget’s main job is to implement a build() function, which describes the widget in terms of other, lower-level widgets. ', likes: '233', comments: '6', shares: '4'),
  new Post(profileImageUrl: 'assets/avatar.jpg', username: 'Ngọc', time: '3 ngày', content: 'The framework builds those widgets in turn until the process bottoms out in widgets that represent the underlying RenderObject, which computes and describes the geometry of the widget.', likes: '77', comments: '7', shares: '2'),
];