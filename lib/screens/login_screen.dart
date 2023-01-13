import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:giris_app/screens/profile_screen.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {




  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        print("No user found for that e-mail");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Login app",
          style: TextStyle(
          color:Colors.black,
          fontSize:28.0,
          fontWeight: FontWeight.bold,
          ),
          ),
          const Text("Login to your app", 
          style: TextStyle(
            color: Colors.black,
            fontSize: 44.0, 
            fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 44.0,),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "User e-mail",
                prefixIcon: Icon(Icons.mail, color: Colors.black),
                ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration:const InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                ),
            ),
            const SizedBox(height: 15.0,),
            const Text(
              "Forgot password?", 
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.blue,
                elevation: 0.0,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onPressed: () async {

                  User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                  print(user);
                  if(user != null ){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen()));
                  } 

                }, 
                child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 18.0),),
              ),
            )
        ],
      ),
    );
  }
}