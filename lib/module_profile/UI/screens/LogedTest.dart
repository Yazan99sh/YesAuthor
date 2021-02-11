import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 51, 51, 1),
      appBar: AppBar(
        backgroundColor: ColorPicker.plateColor,
        title:Text('Profile',style: TextStyle(color: ColorPicker.primaryTextColor),),centerTitle: true,
      leading: IconButton(
        color: ColorPicker.primaryTextColor,
        icon: Icon(Icons.logout),
        onPressed: (){
          widget.authService.logout();
        },
      ),),
      body:FutureBuilder(
        future:widget.profileService.getProfile(),
        builder: (_,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child:Container(
              width: 45,
              height: 45,
              child: CircularProgressIndicator(),
            ),);
          }
          else if (snapshot.hasError){
            return Center(child: Container(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width*0.5,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${snapshot.error.toString()}",overflow: TextOverflow.ellipsis,style: TextStyle(
                        color:ColorPicker.primaryTextColor,
                      ),textAlign: TextAlign.left,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Refresh'),
                      onPressed: (){
                        setState(() {
                        });
                      },
                      color: Colors.red,
                      textColor: ColorPicker.primaryTextColor,
                    ),
                  ),
                ],
              ),
            ));
          }
          else {
            var data = snapshot.data;
            return Center(child: Container(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width*0.5,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text("User name ${data['Data']['userName'].toString()}",overflow: TextOverflow.ellipsis,style: TextStyle(
                          color:ColorPicker.primaryTextColor,
                        ),textAlign: TextAlign.center,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Edit'),
                      onPressed: (){
                        editDialogUserName(context,widget.profileService);
                        setState(() {
                        });
                      },
                      color: Colors.black,
                      textColor: ColorPicker.primaryTextColor,
                    ),
                  ),
                ],
              ),
            ));
          }
        },
      ),
    );
  }
}
//authService.logout();