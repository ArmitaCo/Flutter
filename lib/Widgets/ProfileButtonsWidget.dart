import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';
import 'package:path/path.dart';
class ProfileButtons extends StatelessWidget {
  static BuildContext context;

  ProfileButtons(BuildContext c)
  {
    context=c;
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> buttonsList = new List();
    buttonsList.add(changePassword);
    buttonsList.add(changeMobileNumber);
    buttonsList.add(aboutUs);
    buttonsList.add(bugReport);
    buttonsList.add(inviteFriends);
    buttonsList.add(signOut);

//    return SingleChildScrollView(child:  GridView.builder(
//        itemCount: buttonsList.length,
//        gridDelegate:
//            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
//        itemBuilder: (c, i) {
//          return buttonsList[i];
//        }));

    return Padding(
      child: GridView.count(
        crossAxisCount: 2,
        children: buttonsList,
        childAspectRatio: 3.0,
        mainAxisSpacing:10.0,
        crossAxisSpacing:10.0,
      ),
      padding: EdgeInsets.only(right: 15.0, top: 15.0),
    );
  }

  final RaisedButton changePassword = RaisedButton(
    onPressed: () {},
    child: Text("تغییر کلمه عبور"),elevation: 10.0//,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
  );
  final RaisedButton changeMobileNumber = RaisedButton(
    onPressed: () {},
    child: Text("تغییر شماره موبایل"),elevation: 10.0//,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
  );
  final RaisedButton aboutUs = RaisedButton(
    onPressed: () {},
    child: Text("درباره ما"),elevation: 10.0//,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
  );
  final RaisedButton bugReport = RaisedButton(
    onPressed: () {},
    child: Text("گزارش خرابی"),elevation: 10.0//,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
  );
  final RaisedButton inviteFriends = RaisedButton(
    onPressed: () {},
    child: Text("دعوت دوستان"),elevation: 10.0//,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
  );
  final RaisedButton signOut = RaisedButton(
    onPressed: () {
      Authentication.signout(context);
    },
    child: Text("خروج"),elevation: 10.0//,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
  );
}
