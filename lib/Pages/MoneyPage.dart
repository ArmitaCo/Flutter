import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoneyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MoneyPageState();
}

class MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("خرید بسته",
            textScaleFactor: 1.6,textAlign: TextAlign.center,)
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () {},
                  child:
                      Text("خرید آنلاین (درگاه بانکی)", textScaleFactor: 1.5),
                  padding: EdgeInsets.all(5.0),
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                )),
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "خرید نقدی بسته از صریق درگاه بانکی . با استفاده از این روش کل بسته به صورت نقدی خریداری شده و در اختیار شما قرار می گیرد.",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                )),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {},
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Text(
                  "خرید وس (VAS)",
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "خرید سرویس ارزش افزوده . با استفاده از این روش روزانه مبلغ 1000 ریال ار حساب شما کسر شده و یک جعبه مطلب جدید در اختیار شما قرار می گیرد.",
                  textScaleFactor: 1.3,
                ))
          ],
        ),
      ),
    );
  }
}
