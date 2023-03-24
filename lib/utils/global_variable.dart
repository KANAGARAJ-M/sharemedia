import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharemedia/screens/add_post_screen.dart';
import 'package:sharemedia/screens/feed_screen.dart';
import 'package:sharemedia/screens/profile_screen.dart';
import 'package:sharemedia/screens/qr_generator.dart';
import 'package:sharemedia/screens/search_screen.dart';



const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  // const Text('notifications', textAlign: TextAlign.center,textDirection: TextDirection.rtl,),
  QRCodeScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
