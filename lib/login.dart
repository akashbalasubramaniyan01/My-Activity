import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:myactivity/utils/colors.dart';
import 'package:myactivity/view/home_page.dart';
import 'package:myactivity/view/main_home.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailOrPhone = ''; // State variable for email or phone input
  String password = ''; // State variable for password input
  TextEditingController emailtext = TextEditingController();
  TextEditingController passwordtext = TextEditingController();
  bool emailvalidater = false;
  bool passwordvalidater = false;

  static Future<User?> LoginUsingEmailPassword({required String Email, required String Password,required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email:Email,password:Password);
      user = userCredential.user;
      print(user);
      if(user!=null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(
              builder: (context) => MainHome(),));
      }

    }
    on FirebaseAuthException catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Alert',
        text: 'Email or password wrong',
      );
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/peakpx.jpg"),
              fit: BoxFit.fill,
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
          margin: EdgeInsets.only(left: 12,right: 12),
                decoration:  BoxDecoration(
                  color: Colors.white54.withOpacity(0.3),
                 borderRadius:  const BorderRadius.all(Radius.circular(50))
                 /* borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),*/
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                            boxShadow: [new BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6.0,
                            ),]

                        ),
                        margin: EdgeInsets.all(12),
                        child:  Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.person,
                                color: Colors.black87,
                                size: 20,
                              ),
                            ),

                            Expanded(
                              child: TextField(
                                controller: emailtext,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    emailvalidater=false;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "user Name",
                                  hintStyle: TextStyle(color: Colors.black87),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  isDense: true,
                                ),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                      if(emailvalidater)
                        Container(
                         color: Colors.white,
                            padding: EdgeInsets.all(8),
                            child: Text('Enter the username',style: TextStyle(color: Colors.red,fontSize: 16),)),
                      SizedBox(height: 3),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                            boxShadow: [new BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6.0,
                            ),]

                        ),
                        margin: EdgeInsets.all(12),
                        child:  Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.lock,
                                color: Colors.black87,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: passwordtext,
                                onChanged: (value) {
                                  setState(() {
                                    passwordvalidater=false;
                                  });
                                },
                                decoration: InputDecoration(

                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.black87),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  isDense: true,

                                  suffixIcon:
                                     Icon(
                                      Icons.visibility, size: 20,
                                     ),
                                  ),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if(passwordvalidater)
                        Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(8),child: const Text('Enter the Password',style: TextStyle(color: Colors.red,fontSize: 16),)),
                      SizedBox(height: 28),

                      MaterialButton(
                        onPressed: () {
                          if(emailtext.text=="") {
                            setState(() {
                              emailvalidater = true;
                            });
                          }
                          else if (passwordtext.text==""){
                            setState(() {
                              passwordvalidater = true;
                            });
                          }
                          else{
                            LoginUsingEmailPassword(Email:emailtext.text,Password: passwordtext.text, context: context);

                          }




                        },
                        height: 50,
                        color: MyColors.btnColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                       Text(
                        "Forget Password",
                        style: textTheme.titleSmall,
                      ),
                      const SizedBox(height: 30),
                       Container(

                         child: Row(
                          children: [
                             SizedBox(width: 10),
                          Container(
                              width: size.width/3.5,
                              height: 2,color:Colors.white),
                             InkWell(
                              onTap: () {

                              },
                              child: const Text(
                                " Sign Up ",
                                style:TextStyle(fontSize: 16,color: Colors.lightBlue,fontWeight: FontWeight.w200,fontFamily:"Montserrat" ),
                              ),
                            ),
                            Container(
                                width: size.width/3.5,
                                height: 2,color:Colors.white),
                                               ],),
                       ),
                      const SizedBox(height: 10),
            /*          Row(
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {},
                              height: 50,
                              color: Colors.orange[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  "Facebook",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {},
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              color: Colors.black,
                              child: const Center(
                                child: Text(
                                  "Google",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      )*/
                    ],
                  ),
                ),
              ),
            ),
          SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}
