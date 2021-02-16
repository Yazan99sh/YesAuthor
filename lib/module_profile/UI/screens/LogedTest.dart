import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/Widgets/StackedBottun.dart';
import 'package:c4d/module_profile/UI/widgets/Edit.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_theme/ColorPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logged extends StatefulWidget {
  final AuthService authService;
  final ProfileService profileService;

  Logged(this.authService, this.profileService);

  @override
  _LoggedState createState() => _LoggedState();
}

class _LoggedState extends State<Logged> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 51, 51, 1),
      appBar: AppBar(
        backgroundColor: ColorPicker.plateColor,
        title: Text(
          'Profile',
          style: TextStyle(color: ColorPicker.primaryTextColor),
        ),
        centerTitle: true,
        leading: IconButton(
          color: ColorPicker.primaryTextColor,
          icon: Icon(Icons.logout),
          onPressed: () {
            widget.authService.logout();
          },
        ),
      ),
      body: FutureBuilder(
        future: widget.profileService.getProfile(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                width: 45,
                height: 45,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${snapshot.error.toString()}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ColorPicker.primaryTextColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Refresh'),
                      onPressed: () {
                        setState(() {});
                      },
                      color: Colors.red,
                      textColor: ColorPicker.primaryTextColor,
                    ),
                  ),
                ],
              ),
            ));
          } else {
            var data = snapshot.data;
            return Center(
                child: Container(
                    child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: height * 0.4,
                      color: Colors.grey[800],
                    ),
                    Container(
                      width: double.maxFinite,
                      height: height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(flex: 1,),
                          Text('My name is ${data['Data']['userName']}',style: TextStyle(
                            color: ColorPicker.primaryTextColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: StackedButton(text:'Edit',onPressed: (){
                                  editDialogUserName(context,widget.profileService).whenComplete(() =>(){
                                    setState(() {

                                    });
                                  });
                                },),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 700),
                  builder: (_, val, child) {
                    return Opacity(opacity: val, child: child);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:65),
                    child: Center(
                      child: Container(
                        width: width * 0.25,
                        decoration: BoxDecoration(
                          color:ColorPicker.primaryTextColor,
                            shape: BoxShape.circle,
                            ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/icon.png',fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
          }
        },
      ),
    );
  }
}
//authService.logout();
