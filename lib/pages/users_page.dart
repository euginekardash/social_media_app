import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/my_list_tile.dart';
import 'package:social_media/helper/helper_function.dart';

import '../components/my_back_button.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("Users"),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,elevation: 0,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot){
          //any errors
          if(snapshot.hasError){
            displayMessageToUser("Something went wrong", context);
          }

          //loading circle
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data == null){
            return Text("No users");
          }

          //get all users
          final users = snapshot.data!.docs;

          return Column(
            children: [

              //back button
              const Padding(
                padding: EdgeInsets.only(top: 50.0, left: 25),
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),


              //list of users in the app
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    //get individ user
                    final user = users[index];

                    //get data from each user
                    String username = user['username'];
                    String email = user['email'];

                    return MyListTile(subTitle: email, title: username);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
