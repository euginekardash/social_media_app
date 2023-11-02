import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/mu_button.dart';
import 'package:social_media/components/my_textfield.dart';

import '../helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controler
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  //register method
  void registerUser()async {
    //loading circle
    showDialog(
        context: context,
        builder: (context)=> Center(
          child: CircularProgressIndicator(),
        )
    );

    //make sure password match
    if(passwordController.text != confirmPwController.text){
      //pop loading circle
      Navigator.pop(context);
      //show error
      displayMessageToUser("Password dont match", context);
    }
    //if password do match
    else {
      //try creating the user
      try {
        //create the user
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        //create a user document and add to firestore
        createUserDocument(userCredential);

        //pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop loading circle
        Navigator.pop(context);

        //display error
        displayMessageToUser(e.code, context);
      }
    }
  }
  //create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async{
    if(userCredential != null && userCredential.user!=null){
      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 25,),
              //app name
              Text(
                'R O U N D Y',
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 30,),

              //username textfield
              MyTextField(
                hightText: "Username",
                obscureText: false,
                controller: userNameController,),

              const SizedBox(height: 10,),

              MyTextField(
                hightText: "Email",
                obscureText: false,
                controller: emailController,),

              const SizedBox(height: 10,),

              //password textfield
              MyTextField(
                hightText: "Password",
                obscureText: true,
                controller: passwordController,),

              const SizedBox(height: 10,),

              //confirm password textfield
              MyTextField(
                hightText: "Confirm Password",
                obscureText: true,
                controller: confirmPwController,),

              const SizedBox(height: 10,),

              //forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot password?", style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                ],
              ),

              const SizedBox(height: 25,),

              //register button
              MyButton(
                text: "Register",
                onTap: registerUser,
              ),

              const SizedBox(height: 25,),

              //dont have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an acount?"),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "  Login here", style: TextStyle(fontWeight: FontWeight.bold),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
