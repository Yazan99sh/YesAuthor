import 'package:c4d/module_auth/ui/Widgets/field.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:flutter/material.dart';
void editDialogUserName(context,ProfileService profileService){
  var userName = TextEditingController();
  var alert = AlertDialog(
    shape:RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: Colors.grey[900],
    title: Text('Edit userName',style: TextStyle(
      color: Colors.white,
    ),),
    content:Container(
        height: 100,
        child: Center(child: Field(controller: userName,text: 'UserName',validator:(result) {
          if (result.isEmpty) {
            return 'Please fill this field';
          }
          return null;
        },))),
    actions: [
      FlatButton(child: Text('Confirm',style: TextStyle(
        color: Colors.white,
      ),),onPressed: ()=>profileService.updateProfile(userName.text).then((_) =>Navigator.of(context).pop()),),
      FlatButton(child: Text('Cancel',style: TextStyle(
        color: Colors.white,
      ),),onPressed: ()=>Navigator.of(context).pop(),),
    ],
  );
  showDialog(context: context,builder: (_){
    return alert;
  });
}