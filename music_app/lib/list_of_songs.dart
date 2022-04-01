import 'package:flutter/material.dart';
import 'package:music_app/utils/api_client.dart';

class ListofSongs extends StatefulWidget {
  ListofSongs({Key? key}) : super(key: key);

  @override
  State<ListofSongs> createState() => _ListofSongsState();
}

class _ListofSongsState extends State<ListofSongs> {
  @override
  void initState() {
    //TODO: inplement initstate
    super.initState();
    ApiClient client = ApiClient();
    client.getSongs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('songs'),
      ),
      body: Container(),
    );
  }
}
