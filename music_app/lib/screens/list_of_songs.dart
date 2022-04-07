import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/utils/api_client.dart';
import 'package:shake/shake.dart';

class ListOfSongs extends StatefulWidget {
  const ListOfSongs({Key? key}) : super(key: key);

  @override
  _ListOfSongsState createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {
  AudioPlayer audioPlayer = AudioPlayer();
  int currentSongIndex = 0;
  List<Song> songs = [];
  dynamic error;
  ApiClient client = ApiClient();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      // Do stuff on phone shake
      print("Shake Detect.....");
    });

    detector.startListening();

    client.getSongs(getSongList, getSongError);
  }

  getSongList(List<Song> songs) {
    this.songs = songs;
    setState(() {});
  }

  getSongError(dynamic error) {
    this.error = error;
    setState(() {});
  }

  Center _showLoading() {
    return Center(child: CircularProgressIndicator());
  }

  ListView _printSong() {
    return ListView.builder(
      itemBuilder: (BuildContext ctx, int index) {
        return ListTile(
          leading: Image.network(songs[index].image),
          title: Text(songs[index].trackName),
          subtitle: Text(songs[index].artistName),
          trailing: IconButton(
              onPressed: () async {
                print("Song Play ${songs[index].audio}");
                currentSongIndex = index;
                print("Now the current song index $currentSongIndex");
                await audioPlayer.play(songs[index].audio);
              },
              icon: Icon(
                Icons.play_arrow_rounded,
                size: 30,
                color: Colors.redAccent,
              )),
        );
      },
      itemCount: songs.length,
    );
  }

  TextEditingController searchCtrl = TextEditingController();

  _searchSongs() {
    String searchValueTxt = searchCtrl.text;
    client.getSongs(getSongList, getSongError, searchValue: searchValueTxt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(100),
      //   child: AppBar(
      //     //toolbarHeight: 100,
      //     title: Container(
      //       margin: EdgeInsets.all(20),
      //       decoration: BoxDecoration(
      //           color: Colors.white, borderRadius: BorderRadius.circular(10)),
      //       //color: Colors.white,
      //       child: TextField(
      //         decoration: InputDecoration(
      //             border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(10)),
      //             suffixIcon: Icon(
      //               Icons.search,
      //             ),
      //             labelText: 'Search',
      //             hintText: 'Type to Search'),
      //       ),
      //     ),
      //     //title: Text('Songs'),
      //   ),
      // ),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          //color: Colors.white,
          child: TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    //print("U Click on Search....");
                    _searchSongs();
                  },
                ),
                labelText: 'Search',
                hintText: 'Type to Search'),
          ),
        ),
        //title: Text('Songs'),
      ),
      body:
          Container(child: (songs.length == 0) ? _showLoading() : _printSong()),
    );
  }
}
