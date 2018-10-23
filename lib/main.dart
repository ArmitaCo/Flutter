import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Pages/LoginPage.dart';
import 'package:flutter_app_rote/Pages/RegisterPage.dart';
import 'package:flutter_app_rote/Tools/Dispacher.dart';
import 'package:flutter_app_rote/Tools/MyColors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        "/account/login": (context) => new LoginPage(),
        "/packages": (context) =>
        new MyHomePage(title: 'Flutter Demo Home Page'),
        "/account/register": (context) => new RegisterPage(),
      },

      theme: new ThemeData(buttonColor: MyColors.appBarAndNavigationBar,
        primaryColor: MyColors.appBarAndNavigationBar,
      ),
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
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
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(
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
