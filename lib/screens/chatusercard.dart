import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task3/screens/chatroom.dart';

class ChatUserCard extends StatelessWidget{

  QueryDocumentSnapshot<Map<String, dynamic>> user;
  ChatUserCard({required this.user});

  String generateChatRoomId(String user1,String user2){
    if(user1.hashCode >user2.hashCode){
      return user1+user2;
    }
    else{
      return user2+user1;
    }
  }

  @override
  Widget build(BuildContext context) {

    final currentUser = FirebaseAuth.instance.currentUser;
    return ListTile(
      onTap: (){
        final chatroomid = generateChatRoomId(currentUser!.displayName.toString(),user['name']);
        Get.to(()=>ChatRoom(chatroomid: chatroomid, oppusername: user['name']));
      },
      title: Text(user['name']),
      subtitle: Text(user['email']),
      leading: Icon(Icons.person),
    );
  }

}