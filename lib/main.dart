import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sharemedia/providers/user_provider.dart';
import 'package:sharemedia/responsive/mobile_screen_layout.dart';
import 'package:sharemedia/responsive/responsive_layout.dart';
import 'package:sharemedia/responsive/web_screen_layout.dart';
import 'package:sharemedia/screens/login_screen.dart';
import 'package:sharemedia/utils/colors.dart';
import 'package:provider/provider.dart';


import 'dart:async';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      //Your Firebase API key
      options: const FirebaseOptions(
        apiKey: "AIzaSyC961qcgxLScwEBOX6HydJ-gfibI7rKWPw",
        authDomain: "sharemedia-820ca.firebaseapp.com",
        databaseURL: "https://sharemedia-820ca-default-rtdb.firebaseio.com",
        projectId: "sharemedia-820ca",
        storageBucket: "sharemedia-820ca.appspot.com",
        messagingSenderId: "532195209657",
        appId: "1:532195209657:web:f097b6e5c88c6ca2950668",
        measurementId: "G-SQ6P601YPP"
      ),
    );

  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Share Media',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return  MyHomePage();
          },
        ),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      color: Colors.black,
      child: Image.asset(
        'assets/share_media.png',
        alignment: Alignment.center,
        height: 40,
        width: 90,
      ),
    );
    // child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}

// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("GeeksForGeeks")),
//       body: Center(
//           child: Text(
//         "Home page",
//         textScaleFactor: 2,
//       )),
//     );
//   }
// }
