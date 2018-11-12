import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Pages/LoginPage.dart';
import 'package:flutter_app_rote/Pages/RegisterPage.dart';
import 'package:flutter_app_rote/Tools/Dispacher.dart';
import 'package:flutter_app_rote/Tools/MyColors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return new MaterialApp(
      routes: {
        "/account/login": (context) => new LoginPage(),
        "/packages": (context) =>
            new MyHomePage(title: "نرم افزار مطلب",),
        "/account/register": (context) => new RegisterPage(),
      },
      theme: new ThemeData(
        buttonColor: MyColors.appBarAndNavigationBar,
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        primaryColor: MyColors.appBarAndNavigationBar,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fa', 'IR'), // Farsi
      ],
      locale: Locale("fa"),
      home: new MyHomePage(title: 'نرم افزار مطلب'),
    );
  }


}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Widget body;

  int index = 2;
  String l ="";
  StreamSubscription _sub;
  Future<Null> initUniLinks(BuildContext context) async {
    // ... check initialLink

    // Attach a listener to the stream

    _sub = getLinksStream().listen((String link) {
      l=link;
      final u = Uri.parse(link);
      Navigator.pushNamed(context, "/packages");
      // Parse the link and warn the user, if it is not correct
    }, onError: (err) {
      l=err.toString();
      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }

  setBody(Widget w) {
    setState(() {
      body = w;
    });
  }

  @override
  void initState() {
    super.initState();
    dispatch(pages.packages, context).then((w) {
      if (w != null) {
        setBody(w);
      }
    });
    initUniLinks(context);
    //Authentication.read(context);
  }

  navigationTapped(int i) {
    dispatch(pages.values[i], context).then((w) {
      if (w != null) {
        setBody(w);
        index = i;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(child: new Text(widget.title)),
      ),
      body: Center(child: body),
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              canvasColor: MyColors.appBarAndNavigationBar,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(
                      color: Colors.red,
                      fontSize: 50.0,
                      fontStyle: FontStyle.italic))),
          child: BottomNavigationBar(
              currentIndex: index,
              onTap: navigationTapped,
              type: BottomNavigationBarType.shifting,
              iconSize: 30.0,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), title: Text("خرید")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.golf_course), title: Text("مسابقه")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), title: Text("بسته ها")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), title: Text("جستجو")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.insert_emoticon), title: Text("پروفایل")),
              ])),
    );
  }
}
