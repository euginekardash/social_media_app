import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/my_drawer.dart';
import 'package:social_media/components/my_list_tile.dart';
import 'package:social_media/components/my_textfield.dart';
import 'package:social_media/firebase/firestore.dart';

import '../components/my_post_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  //text controller
  final TextEditingController newPostController = TextEditingController();

  //post message
  void postMessage(){
    //only post message if there is something in textfield
    if(newPostController.text.isNotEmpty){
      String message = newPostController.text;
      database.addPost(message);
    }

    //clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text("R O U N D Y"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,

      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          //textfield box for user to type
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                //textfield
                Expanded(
                  child: MyTextField(
                      hightText: "Say something...", obscureText: false, controller: newPostController
                  ),
                ),

                //post button
                PostButton(
                  onTap: postMessage,)
              ],
            ),
          ),

          //posts
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot){
                //show loading circle
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                //get all posts
                final posts = snapshot.data!.docs;

                //no data
                if(snapshot.data == null || posts.isEmpty){
                  return const Center(
                    child: Padding(padding: EdgeInsets.all(25), child: Text("No posts... Post something!"),),

                  );
                }

                //return as a list
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index){
                      //get each indivit post
                      final post = posts[index];
                        //get data from each post
                      String message = post['postMessage'];
                      String userEmail = post['UserEmail'];
                      Timestamp timestamp = post['TimeStamp'];
                        //return as a list tile
                        return MyListTile(subTitle: userEmail, title: message);
                      },
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}
