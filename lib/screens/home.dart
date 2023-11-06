import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task3/screens/availableuser.dart';
import 'package:task3/screens/chatroom.dart';
import 'package:task3/screens/settingscreen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
        leading: const Icon(Icons.home),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>MySettings());
          }, icon: const Icon(Icons.settings),),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Chats").snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.data!.docs.isNotEmpty){
            print("Kuch hai");
            return ListView.builder(itemCount: snapshot.data?.docs.length,itemBuilder: (context,index){
              if(snapshot.data!.docs[index].data().keys.first.contains(_auth.currentUser!.displayName.toString())) {
                List recentChats = snapshot.data!.docs[index].data().values.first;
                return Column(
                  children: [
                    ListTile(
                      onTap: (){
                        Get.to(()=>ChatRoom(chatroomid: snapshot.data!.docs[index].data().keys.first, oppusername: recentChats.last['reciever'].toString()),transition: Transition.cupertino);
                      },
                      title: Text(_auth.currentUser!.displayName!.contains(recentChats.last['sentby'])?recentChats.last['reciever']:recentChats.last['sentby']),
                      subtitle: Text("${recentChats.last['sentby'].toString()} : ${recentChats.last['message'].toString()}"),
                    ),
                    const Divider(),
                  ],
                );
              }
            });
          }
          return Center(child: Text("No Chats Available",style: Theme.of(context).textTheme.titleMedium,),);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=>AvailableUser(),transition: Transition.cupertino);
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}



/*
if(snapshots.data!.docs.toString().contains(_auth.currentUser!.displayName.toString())) {
return Text("Into THe ChatRoom with ${oppuser['name']}");
}*/
