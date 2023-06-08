import 'package:flutter/material.dart';
import 'package:to_do_app/screen/notes_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) =>  const NotesScreenPage())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: 300,
        height: 150,
        child: Image.network(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCoj3w5JKb_Rycll_EbJ73WolHwkqw7VjOmw&usqp=CAU",
        ),
      ),
    );
  }
}
