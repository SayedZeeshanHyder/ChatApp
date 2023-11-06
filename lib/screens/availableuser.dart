import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task3/screens/chatusercard.dart';

class AvailableUser extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final _currentUser =  FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Users"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator());
            }
          if(snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final document = snapshot.data!.docs[index];
                  if (document['uid'] == _currentUser!.uid) {
                    return SizedBox();
                  }
                  return ChatUserCard(user: document);
                });
          }
          return Center(child: Text("No User Available",style: Theme.of(context).textTheme.titleMedium,),);

        },
      ),
    );
  }
  
}