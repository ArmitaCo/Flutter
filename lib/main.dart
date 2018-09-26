import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Login.dart';
import 'Dispacher.dart';
import 'RegisterPage.dart';
import 'package:flutter_app_rote/Authentication.dart';
import 'package:flutter_app_rote/PackagesPage2.dart';

void main() => runApp(
    new MaterialApp(

      routes: {
        "/account/login": (context) => new LoginPage(),
        "/packages": (context) =>
        new MyHomePage(title: 'Flutter Demo Home Page'),
        "/account/register" :(context)=> new RegisterPage(),
      },
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),

    )

);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      routes: {
        "/account/login": (context) => new LoginPage(),
        "/packages": (context) =>
            new MyHomePage(title: 'Flutter Demo Home Page'),
        "/account/register" :(context)=> new RegisterPage(),
      },
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
      
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
      if(w!=null) {
        setBody(w);
      }
    });
    //Authentication.read(context);
  }

  navigationTapped(int i) {

    dispatch(pages.values[i], context).then((w) {
      if(w!=null) {
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
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app),tooltip: "خروج", onPressed: (){
            Authentication.Signout(context);})
        ],
      ),
      body: Center(child: body),
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.blue,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
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
