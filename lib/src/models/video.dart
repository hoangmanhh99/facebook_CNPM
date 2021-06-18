class Video {
  String url = '';
  String thumb = '';

  Video.origin();

  Video(this.url, this.thumb);

  Video.fromJson(Map map) {
    this.url = map['url'];
    this.thumb = map['thumb'];
  }

  Map toMap() => new Map<String, dynamic>.from({
    "url": this.url,
    "thumb": this.thumb
  });

  static List<Map> toListMap(List<Video> videos) {
    List<Map> maps = [];
    videos.forEach((Video video) {
      Map step = video.toMap();
      maps.add(step);
    });
    return maps;
  }

  static List<Video> fromListMap(List<Map> maps) {
    List<Video> videos = [];
    maps.forEach((element) {
      videos.add(Video.fromJson(element));
    });
    return videos;
  }
}