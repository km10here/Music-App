import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/list_of_songs.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "MusicApp 2022",
    home: ListofSongs(),
  ));
}
