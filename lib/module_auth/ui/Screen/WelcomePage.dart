import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:flutter/material.dart';
class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          //Background image welcome.png
          Image.asset(
            'assets/images/welcome.jpg',
            fit: BoxFit.cover,
            height: double.maxFinite,
          ),
          //Login or Register section , I used here center with column to turn around stacks fitted size
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //Logo image in almost at the center of screen
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 2.8,
                  ),
                ),
              ),
              //Title with his sub and tow flatButton with fixed height and divider in the middle of them
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 12.0),
                          child: Text(
                            'Welcome to Yes Author',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Login or Register to get started',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        Container(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              FlatButton(
                                minWidth: double.maxFinite,
                                height: 55,
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context,AuthorizationRoutes.LOGIN_SCREEN);
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8, left: 8),
                                child: Divider(
                                  color: Colors.grey.withOpacity(0.4),
                                  height: 0.1,
                                  thickness: 0.2,
                                ),
                              ),
                              FlatButton(
                                minWidth: double.maxFinite,
                                height: 55,
                                onPressed: () {
                                  Navigator.pushNamed(context,AuthorizationRoutes.REGISTER_SCREEN);
                                },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
