class Song {
  late String artistName; //artist of the song
  late String trackName; //song name
  late String image; //image URL
  late String audio; //song URL
  Song(this.artistName, this.trackName, this.image, this.audio);
// manual serialization and deserialization
// serialization - object to json conversion
// deserialization - json to object conversion

//named constructor
  Song.fromJSON(Map<String, dynamic> map) {
    this.artistName = map['artistName'];
    this.trackName = map['trackName'];
    this.image = map['artworkUrl100'];
    this.audio = map['previewUrl'];
  }

  toJSON() {}
}
