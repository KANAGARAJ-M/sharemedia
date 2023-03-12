import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharemedia/utils/colors.dart';
import 'package:sharemedia/utils/global_variable.dart';
import 'package:sharemedia/widgets/post_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late final WebViewController controller;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              // title: Svg.asset('assets/photo_sharing_logo.png',
              // height: 32,
              // ),
              title: Text('Photo sharing Platform',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: signup_button)),

              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.web,
                      color: primaryColor,
                    ),
                    onPressed: () async {
                      const url = "http://web.tamilanproject.xyz";
                      final Uri _url = Uri.parse(url);
                      await launchUrl(_url,mode: LaunchMode.externalApplication);
                    }),
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Added to favorite'),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

// _launchURLBrowser() async {
//   const uri = Uri.parse("https://flutter.io");
// if (await canLaunchUrl(uri)){
//     await launchUrl(uri);
// } else {
//     // can't launch url
// }
// }
